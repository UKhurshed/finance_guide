import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text("Лента уведомлений", style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w500, color: kItemUnSelected),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            children: [
              ListTile(
                leading: Image.asset("assets/launcher/ethereum.png",),
                title: Text("Ethereum", style: TextStyle(color: kEtherColor, fontSize: 20),), //
                subtitle: Text("Котировки достигли отметки 1,171.60", style: TextStyle(color: kEtherColor, fontSize: 16)),
              )
            ]
        ),
      ),
    );
  }
}
