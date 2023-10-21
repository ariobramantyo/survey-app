part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final bool formStatus;
  final Email email;
  final PasswordSecure password;
  final String? message;

  const LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.formStatus = false,
      this.email = const Email.pure(),
      this.password = const PasswordSecure.pure(),
      this.message});

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      bool? formStatus,
      Email? email,
      PasswordSecure? password,
      String? message}) {
    return LoginState(
        status: status ?? this.status,
        formStatus: formStatus ?? this.formStatus,
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [status, email, formStatus, password, message];
}
