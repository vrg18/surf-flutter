import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'top_bar.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: currentThemeIsDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarTitleHeight),
        child: TopBar(
          titleHeight: appBarTitleHeight,
          bottomHeight: 0,
          title: Text(
            firstLandscapeScreenTitle,
            style: screenTitleStyle,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: Container(),
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
