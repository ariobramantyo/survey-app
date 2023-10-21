import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/exception.dart';
import '../datasource/auth_data_source.dart';
import '../../../../core/util/data_mapper.dart';
import '../../../../core/error/failure.dart';
import '../../domain/model/user_entity.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final AuthDataSource _authDataSource;
  final FlutterSecureStorage _flutterSecureStorage;

  static final AuthRepositoryImpl _instance = AuthRepositoryImpl.internal();

  factory AuthRepositoryImpl() => _instance;

  AuthRepositoryImpl.internal({
    AuthDataSource? authDataSource,
    FlutterSecureStorage? flutterSecureStorage,
  })  : _authDataSource = authDataSource ??
            AuthDataSourceImpl(
              client: http.Client(),
              secureStorage:
                  flutterSecureStorage ?? const FlutterSecureStorage(),
            ),
        _flutterSecureStorage =
            flutterSecureStorage ?? const FlutterSecureStorage();

  @override
  void dispose() {
    _controller.close();
  }

  @override
  Future<Either<Failure, UserEntity>> getUserCredential() async {
    try {
      final userCred = await _authDataSource.getUserCredential();
      return right(DataMapper.mapUserDtoToEntity(userCred));
    } catch (e) {
      return left(const LocalFailure('Failed to load user credential'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final loginResponse = await _authDataSource.login(email, password);
      _controller.add(AuthenticationStatus.authenticated);
      setUserCredential(DataMapper.mapLoginResponseToEntity(loginResponse));

      return right(DataMapper.mapLoginResponseToEntity(loginResponse));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authDataSource.logout();

      _controller.add(AuthenticationStatus.unauthenticated);

      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    final user = await _flutterSecureStorage.read(key: 'TOKEN');

    if (user == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }

    yield* _controller.stream;
  }

  @override
  Future<void> setUserCredential(UserEntity user) async {
    try {
      await _authDataSource.setUserCredential(DataMapper.mapEntityToDto(user));
    } catch (e) {
      debugPrint(e.toString());
      throw LocalException('Gagal menyimpan user credential');
    }
  }
}
