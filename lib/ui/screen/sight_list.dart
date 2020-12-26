import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/point.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> {
  List<SightCard> _listNearbySight = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<CurrentTheme>().isDark ? Brightness.light : Brightness.dark,
    ));

    _listNearbySight.clear();
    mocks.forEach((sight) {
      if (!arePointsNear(sight.point, currentPoint, searchRadius.start) &&
          arePointsNear(sight.point, currentPoint, searchRadius.end) &&
          selectedCategories.contains(sight.category)) {
        _listNearbySight.add(SightCard(sight));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        bottomHeight: 0,
        title: Text(
          firstLandscapeScreenTitle,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: const SizedBox.shrink(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: GridView.extent(
          maxCrossAxisExtent: wideScreenSizeOver,
          crossAxisSpacing: basicBorderSize,
          mainAxisSpacing: basicBorderSize,
          childAspectRatio: 1.5,
          children: _listNearbySight,
        ),
      ),
    );
  }
}
