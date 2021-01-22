import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'guide.dart';
import 'guide_card.dart';
import 'dart:math' as math;

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Справочник тех. индикаторов"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            GuideCarousel(),
          ],
        ),
      ),
    );
  }
}

class GuideCarousel extends StatefulWidget {
  @override
  _GuideCarouselState createState() => _GuideCarouselState();
}

class _GuideCarouselState extends State<GuideCarousel> {
  PageController _pageController;
  int initialPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: AspectRatio(
          aspectRatio: 0.85,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                initialPage = value;
              });
            },
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            itemCount: guide.length,
            itemBuilder: (context, index) => buildGuideSlider(index),
          )),
    );
  }

  Widget buildGuideSlider(int index) => AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = index - _pageController.page;
          value = (value * 0.038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          opacity: initialPage == index ? 1 : 0.4,
          duration: Duration(milliseconds: 350),
          child: Transform.rotate(
            angle: math.pi * value,
            child: GuideCard(guide: guide[index]),
          ),
        );
      });
}
