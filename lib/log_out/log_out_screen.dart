import 'package:finance_guide/authentication/authentication.dart';
import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationBloc>().state.user;
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
                  height: 50,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      fontSize: 28),
                ),
                SizedBox(
                  height: 75,
                ),
                Container(
                  height: 48,
                  width: 146,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () => context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested()),
                    color: Colors.white,
                    child: Text(
                      "Выйти",
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
