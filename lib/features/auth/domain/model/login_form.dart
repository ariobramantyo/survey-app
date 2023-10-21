import 'package:formz/formz.dart';

import 'email.dart';
import 'password.dart';

class LoginForm with FormzMixin {
  LoginForm({
    this.username = const Email.pure(),
    this.password = const Password.pure(),
  });

  final Email username;
  final Password password;

  @override
  List<FormzInput> get inputs => [username, password];
}
