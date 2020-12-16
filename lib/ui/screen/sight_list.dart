import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'top_bar.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> {
  @override
  Widget build(BuildContext context) {
    bool wideScreen = MediaQuery.of(context).size.width > wideScreenSizeOver;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        height: wideScreen ? 55 : 100,
        backgroundColor: Colors.white,
        title: Text(
          wideScreen ? firstLandscapeScreenTitle : firstPortraitScreenTitle,
          style: screenTitleStyle,
          maxLines: wideScreen ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: GridView.extent(
          maxCrossAxisExtent: wideScreenSizeOver,
          crossAxisSpacing: basicBorderSize,
          mainAxisSpacing: basicBorderSize,
          childAspectRatio: 1.5,
          children: mocks.map((e) => SightCard(e)).toList(),
        ),
      ),
    );
  }
}
