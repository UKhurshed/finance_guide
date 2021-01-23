import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 73,
                ),
                Container(
                    child: Image.asset(
                  "assets/launcher/Group.png",
                  height: 115,
                  width: 120,
                )),
                SizedBox(
                  height: 120,
                ),
                Container(
                  height: 46,
                  margin: const EdgeInsets.only(left: 37, right: 38),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    // onChanged: (email) =>
                    //     context.read<LoginCubit>().emailChanged(email),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "E-mail или Телефон",
                        hintStyle: TextStyle(color: kHintColor, fontSize: 13),
                        // helperText: '',
                        // errorText: state.email.invalid ? 'invalid email' : null,
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  // color: kWhite,
                  height: 48,
                  width: 205,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // onPressed: () => context
                    //     .read<AuthenticationBloc>()
                    //     .add(AuthenticationLogoutRequested()),
                    color: kWhite,
                    onPressed: () {
                      auth.sendPasswordResetEmail(email: email);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Напомнить пароль",
                      style: TextStyle(
                          color: kHintColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
