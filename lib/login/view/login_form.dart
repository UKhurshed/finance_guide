import 'package:finance_guide/login/cubit/login_cubit.dart';
import 'package:finance_guide/sign_up/view/sign_up_screen.dart';
import 'package:finance_guide/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _EmailInput(),
            _PasswordInput(),
            const SizedBox(height: 10.0),
            _LoginButton(),
            const SizedBox(height: 10.0),
            _SignUpButton(),
            const SizedBox(height: 10.0),
            _GoogleLoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.email.invalid ? 'invalid password' : null,
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
          width: 150,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffffae88), Color(0xff8f93ea)],
            ),
          ),
          child: MaterialButton(
              onPressed: state.status.isValidated
                  ? () =>
                  context.read<LoginCubit>().logInWithCredentials()
                  : null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return RaisedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.blueAccent),
      ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.blueAccent),
      elevation: 0,
      color: Color(0xfff4ced9),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return GradientButton(
      width: 150,
      height: 45,
      text: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
    );
  }
}