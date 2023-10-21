import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/model/user_entity.dart';
import '../../../domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final AuthRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthBloc({
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthState.unknown()) {
    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthenticationStatus.authenticated:
          final user = await _getUserCredential();
          emit(user != null
              ? const AuthState.authenticated()
              : const AuthState.unauthenticated());
          break;
        case AuthenticationStatus.unauthenticated:
          emit(const AuthState.unauthenticated());
          break;
        case AuthenticationStatus.unknown:
          emit(const AuthState.unknown());
          break;
      }
      notifyListeners();
    });

    on<AuthenticationLogoutRequested>((event, emit) {
      _authenticationRepository.logout();
    });

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<UserEntity?> _getUserCredential() async {
    final userCredEither = await _authenticationRepository.getUserCredential();

    UserEntity? userEntity;

    userCredEither.fold(
      (l) {
        userEntity = null;
      },
      (r) {
        userEntity = r;
      },
    );

    return userEntity;
  }
}
