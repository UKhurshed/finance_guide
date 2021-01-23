import 'package:finance_guide/sign_up/sign_up.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 37),
            alignment: Alignment.centerLeft,
            child: Text(
              'Введите e-mail или телефон',
              style: TextStyle(
                  fontSize: 15, color: kWhite, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _EmailInput(),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.only(left: 37),
            alignment: Alignment.centerLeft,
            child: Text(
              'Пароль',
              style: TextStyle(
                  fontSize: 15, color: kWhite, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _PasswordInput(),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.only(left: 37),
            alignment: Alignment.centerLeft,
            child: Text(
              'Повторите пароль',
              style: TextStyle(
                  fontSize: 15, color: kWhite, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _ConfirmPasswordInput(),
          const SizedBox(height: 45),
          _SignUpButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: '+79000000000',
              // helperText: '',
              // errorText: state.email.invalid ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              hintText: '********',
              // helperText: '',
              // errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Container(
          height: 46,
          margin: const EdgeInsets.only(left: 37, right: 38),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              hintText: '********',
              // labelText: '********',
              // helperText: '',
              // errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: 160,
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () =>
                      context.read<SignUpCubit>().signUpFormSubmitted(),
                  color: Colors.white,
                  child: Text(
                    "Регистрация",
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
