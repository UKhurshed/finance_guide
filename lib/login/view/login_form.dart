import 'package:finance_guide/login/cubit/login_cubit.dart';
import 'package:finance_guide/sign_up/view/sign_up_screen.dart';
import 'package:finance_guide/utils/constants.dart';
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
      child: Column(
        children: [
          _EmailInput(),
          SizedBox(
            height: 10,
          ),
          _SignUpButton(),
          SizedBox(
            height: 10,
          ),
          _PasswordInput(),
          const SizedBox(height: 35.0),
          _LoginButton(),
          const SizedBox(height: 10.0),
          Text(
            "Забыли пароль?",
            style: TextStyle(color: kForgetPass, fontSize: 14),
          )
          // _SignUpButton(),
          // const SizedBox(height: 10.0),
          // _GoogleLoginButton(),
        ],
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
          return Container(
            height: 46,
            margin: const EdgeInsets.only(left: 37, right: 38),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "E-mail или Телефон",
                  hintStyle: TextStyle(color: kHintColor, fontSize: 13),
                  // helperText: '',
                  // errorText: state.email.invalid ? 'invalid email' : null,
                  border: OutlineInputBorder()),
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
          return Container(
            height: 46,
            margin: const EdgeInsets.only(left: 37, right: 38),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Пароль",
                  hintStyle: TextStyle(
                      color: kHintColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  // helperText: '',
                  // errorText: state.email.invalid ? 'invalid password' : null,
                  // errorText: state.password.invalid ? 'invalid password' : null,
                  border: OutlineInputBorder()),
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
                height: 48,
                width: 146,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed:
                      //state.status.isValidated ?
                      () => context.read<LoginCubit>().logInWithCredentials(),
                  //: null,
                  color: Colors.white,
                  child: Text(
                    "Вход",
                    style: TextStyle(
                        color: kHintColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
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
    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(SignUpScreen.route()),
      child: Container(
        margin: const EdgeInsets.only(left: 37),
        alignment: Alignment.centerLeft,
        child: Text(
          'Зарегистрироваться',
          style: TextStyle(
              fontSize: 13, color: kYellowSignUp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
