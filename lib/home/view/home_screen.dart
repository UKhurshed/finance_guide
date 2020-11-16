import 'package:finance_guide/home/drawer/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
