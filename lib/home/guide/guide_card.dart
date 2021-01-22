import 'package:animations/animations.dart';
import 'package:finance_guide/home/guide/detail_screen/guide_detail_screen.dart';
import 'package:finance_guide/home/guide/guide.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';

class GuideCard extends StatelessWidget {
  final Guide guide;

  const GuideCard({this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildColumn(context),
        openBuilder: (context, action) => GuideDetailScreen(
          guide: guide,
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [kDefaultShadow],
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(guide.imageDesc),
              )),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Text(
            guide.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
