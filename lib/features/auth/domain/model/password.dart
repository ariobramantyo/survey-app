import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return null;
  }
}

class PasswordSecure extends FormzInput<String, PasswordValidationError> {
  const PasswordSecure.pure() : super.pure('');

  const PasswordSecure.dirty([super.value = '']) : super.dirty();

  static String? getErrorText(PasswordValidationError? errorType) {
    switch (errorType) {
      case PasswordValidationError.empty:
        return 'Password tidak boleh kosong.';
      default:
        return null;
    }
  }

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return null;
  }
}
