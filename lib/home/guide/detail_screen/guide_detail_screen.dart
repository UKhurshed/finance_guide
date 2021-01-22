import 'package:finance_guide/home/guide/guide.dart';
import 'package:flutter/material.dart';

class GuideDetailScreen extends StatelessWidget {
  final Guide guide;

  const GuideDetailScreen({this.guide});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(guide.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(guide.imageDesc),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(guide.description, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }
}
