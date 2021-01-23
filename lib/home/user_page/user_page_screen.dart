import 'package:finance_guide/authentication/bloc/authentication_bloc.dart';
import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/home/user_page/favorites/favorites_screen.dart';
import 'package:finance_guide/home/user_page/notification/notification_screen.dart';
import 'package:finance_guide/log_out/log_out_screen.dart';
import 'package:finance_guide/login/view/login_screen.dart';
import 'package:finance_guide/sign_up/sign_up.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationBloc>().state.user;
    var index = user.email.isEmpty;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
          // titleSpacing: 0,
          centerTitle: true,
          leadingWidth: 130,
          backgroundColor: kAppBar,
          automaticallyImplyLeading: false,
          leading: index
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12, bottom: 10),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context, SignUpScreen.route(), (route) => false),
                      child: Text(
                        "Зарегистрировать",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: kWhite),
                      ),
                      color: kSignUpUser),
                )
              : GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogOutScreen()));
                  },
                  child: ImageIcon(
                    AssetImage(
                      "assets/launcher/account.png",
                    ),
                    color: kWhite,
                    size: 35,
                  ),
                ),
          title: index
              ? Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10, left: 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kTitleGreen,
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context, LoginScreen.route(), (route) => false),
                    child: Text("Войти",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: kWhite)),
                  ),
                )
              : Text(user.email),
          actions: [
            IconButton(
                icon: ImageIcon(AssetImage("assets/launcher/setting.png")),
                onPressed: () {})
          ],
        ),
        body: Column(
          children: [
            Container(
              color: kLiked,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoritesScreen()));
                          },
                          child: ImageIcon(
                            AssetImage("assets/launcher/star.png"),
                            color: kAppBar,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Избранное",
                          style: TextStyle(fontSize: 12, color: kAppBar),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        color: kWhite,
                        height: 3,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60, top: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationScreen()));
                          },
                          child: ImageIcon(
                            AssetImage("assets/launcher/notifications.png"),
                            color: kAppBar,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Уведомления",
                          style: TextStyle(fontSize: 12, color: kAppBar),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Наши Партнёры и друзья:",
              style: TextStyle(fontSize: 28, color: kAppBar),
            ),
            SizedBox(
              height: 27,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/launcher/forex.png",
                          width: 70, height: 70),
                      Text(
                        "Робофорекс",
                        style: TextStyle(fontSize: 14, color: kAppBar),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset("assets/launcher/alpari.png",
                          width: 70, height: 70),
                      Text("Альпари",
                          style: TextStyle(fontSize: 14, color: kAppBar))
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset("assets/launcher/fxpro.png",
                          width: 70, height: 70),
                      Text("FxPro",
                          style: TextStyle(fontSize: 14, color: kAppBar))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 35),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/launcher/tinkof.png",
                          width: 57, height: 57),
                      Text(
                        "Тинькофф Инвестиции",
                        style: TextStyle(fontSize: 20, color: kWhite),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/launcher/sber.png",
                          width: 57, height: 57),
                      Text(
                        "Сбербанк Инвестор",
                        style: TextStyle(fontSize: 20, color: kWhite),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/launcher/vtb.png",
                          width: 57, height: 57),
                      Text(
                        "Сбербанк Инвестор",
                        style: TextStyle(fontSize: 20, color: kWhite),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
