import 'package:auth_repository/auth_repository.dart';
import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/login/login.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (_) => LoginCubit(
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
                // SizedBox(
                //   height: 140,
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 120),
                  child: LoginForm(),
                )
              ],
            ),
          ),
        ),
      )),
    ));
  }
}

//
// class LoginScreen extends StatelessWidget {
//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => LoginScreen());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
//       body: BlocProvider(
//         create: (_) => LoginCubit(
//           context.read<Repository>(),
//         ),
//         child: Container(
//             height: double.infinity,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xfff2cbd0), Color(0xfff4ced9)],
//                 )),
//             child: SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     CurvedWidget(
//                       child: Container(
//                         padding: const EdgeInsets.only(top: 100, left: 50),
//                         width: double.infinity,
//                         height: 250,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [Colors.white, Colors.white.withOpacity(0.4)],
//                           ),
//                         ),
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 40,
//                             color: Color(0xff6a515e),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                         margin: const EdgeInsets.only(top: 180), child: LoginForm())
//                   ],
//                 ))),
//       ),
//     );
//   }
// }
