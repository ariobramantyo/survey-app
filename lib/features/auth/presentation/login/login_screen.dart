import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/theme/color.dart';
import '../../../../core/theme/typo.dart';
import '../../domain/model/email.dart';
import '../../domain/model/password.dart';
import '../../domain/repository/auth_repository.dart';
import '../component/auth_text_field.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text(state.message ?? 'Login failed',
                        style: const TextStyle(fontSize: 12))));
            } else if (state.status.isSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: const Text('Login Success',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  backgroundColor: Theme.of(context).primaryColor,
                ));
            }
          },
          child: SafeArea(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Text(
                    'Login to Synapsis',
                    style: AppTypography.title.copyWith(fontSize: 21),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _EmailInput(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _PasswordInput(),
                ),
                const SizedBox(height: 5),
                CheckboxListTile(
                  title: Text(
                    "Remember me",
                    style: AppTypography.regular
                        .copyWith(fontSize: 15, color: AppColor.secondaryText),
                  ),
                  fillColor: MaterialStateProperty.all(AppColor.primary),
                  value: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 30),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _LoginButton()),
                const SizedBox(height: 5),
                Center(
                  child: Text('or',
                      style: AppTypography.regular
                          .copyWith(fontSize: 15, color: AppColor.primary)),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 43),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(color: AppColor.primary)),
                      ),
                      child: Text(
                        'Fingerprint',
                        style: AppTypography.buttons
                            .copyWith(fontSize: 15, color: AppColor.primary),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AuthTextField(
          label: 'Email',
          hint: 'Input your email',
          errorText: (state.status.isInitial)
              ? null
              : Email.getErrorText(state.email.error),
          onChanged: (email) {
            context.read<LoginBloc>().add(LoginEmailChanged(email));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  var _passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AuthTextField(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _passwordObscure = !_passwordObscure;
                });
              },
              padding: EdgeInsets.zero,
              icon: _passwordObscure
                  ? const Icon(
                      Icons.visibility_off,
                      // size: 20,
                      color: AppColor.subText,
                    )
                  : const Icon(
                      Icons.visibility,
                      // size: 20,
                      color: AppColor.subText,
                    )),
          obscure: _passwordObscure,
          errorText: (state.status.isInitial)
              ? null
              : PasswordSecure.getErrorText(state.password.error),
          onChanged: (password) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password),
              ),
          label: 'Password',
          hint: 'Input your password',
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: state.email.isValid && state.password.isValid
                ? () {
                    if (state.status.isInitial ||
                        (!state.status.isInProgress && state.formStatus)) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              minimumSize: const Size(double.infinity, 43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: state.status.isInProgress
                ? const Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  )
                : Text(
                    'Login',
                    style: AppTypography.buttons
                        .copyWith(fontSize: 15, color: Colors.white),
                  ));
      },
    );
  }
}
