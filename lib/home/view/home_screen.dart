import 'package:finance_guide/home/currency/currency_screen.dart';
import 'package:finance_guide/home/drawer/drawer.dart';
import 'package:finance_guide/home/guide/guide_screen.dart';
import 'package:finance_guide/home/ideas/ideas_screen.dart';
import 'package:finance_guide/home/news/news.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:finance_guide/home/user_page/user_page_screen.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    pageList.add(IdeasScreen());
    pageList.add(QuoteMain());
    // pageList.add(Currency());
    pageList.add(News());
    pageList.add(UserPageScreen());
    pageList.add(GuideScreen());
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  int _currentIndex = 0;

  Widget _bottomNavigationBar(int currentIndex) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kItemSelected,
          unselectedItemColor: kItemUnSelected,
          onTap: (int index) => setState(() => _currentIndex = index),
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/launcher/light.png")), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/launcher/quotes.png")),  label: ""),
            // BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.textsms,
                ),
                label: ''),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/launcher/user.png")), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.speaker_notes), label: "")
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      // drawer: AppDrawer(),
      bottomNavigationBar: _bottomNavigationBar(_currentIndex),
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
    );
  }
}


