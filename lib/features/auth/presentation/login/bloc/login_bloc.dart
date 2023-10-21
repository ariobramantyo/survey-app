import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:survey_app/features/auth/domain/model/email.dart';
import 'package:survey_app/features/auth/domain/model/password.dart';
import 'package:survey_app/features/auth/domain/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      final email = Email.dirty(event.email);
      emit(
        state.copyWith(
          email: email,
          formStatus: Formz.validate([state.password, email]),
          status: FormzSubmissionStatus.canceled,
        ),
      );
    });

    on<LoginPasswordChanged>((event, emit) {
      final password = PasswordSecure.dirty(event.password);
      emit(
        state.copyWith(
          password: password,
          formStatus: Formz.validate([state.email, password]),
          status: FormzSubmissionStatus.canceled,
        ),
      );
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.formStatus) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

        final loginResultEither = await _authRepository.login(
          state.email.value,
          state.password.value,
        );

        loginResultEither.fold(
          (failure) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure, message: failure.message)),
          (userEntity) =>
              emit(state.copyWith(status: FormzSubmissionStatus.success)),
        );

        // try {
        //   await _authRepository.login(
        //     state.email.value,
        //     state.password.value,
        //   );
        //   emit(state.copyWith(status: FormzSubmissionStatus.success));
        // } on Exception catch (e) {
        //   print(e.toString());
        //   emit(state.copyWith(
        //       status: FormzSubmissionStatus.failure, message: e.toString()));
        // } catch (e) {
        //   print(e.toString());

        //   emit(state.copyWith(
        //       status: FormzSubmissionStatus.failure,
        //       message: 'Terjadi kesalahan, coba lagi nanti.'));
        // } finally {
        //   print('error login');

        //   emit(state.copyWith(
        //       formStatus: Formz.validate([state.email, state.password])));
        // }
      }
    });
  }
}
