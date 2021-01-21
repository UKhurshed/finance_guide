import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text("Избранное", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: kItemUnSelected),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Пусто", style: TextStyle(color: kWhite),),
          ),
        ],
      ),
    );
  }
}
