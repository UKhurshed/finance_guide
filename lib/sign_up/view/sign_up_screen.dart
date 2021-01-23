import 'package:auth_repository/auth_repository.dart';
import 'package:finance_guide/sign_up/sign_up.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:finance_guide/widgets/curved_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(
              context.read<Repository>(),
            ),
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
                      height: 5,
                    ),
                    Text(
                      "InvestTech",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 32, color: kWhite),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: SignUpForm(),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}



/*
Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfff2cbd0), Color(0xfff4ced9)],
                ),
              ),
              child: SingleChildScrollView(
                  child: Stack(children: [
                    CurvedWidget(
                      child: Container(
                        padding: const EdgeInsets.only(top: 100, left: 50),
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.white.withOpacity(0.4)],
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff6a515e),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 210),
                      child: SignUpForm(),
                    )
                  ])),
            ),
 */