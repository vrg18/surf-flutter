import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Виджет - текстовая часть экрана детализации места
class SightDetailDescription extends StatelessWidget {
  final Sight _sight;

  SightDetailDescription(this._sight);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 3,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.bottomLeft,
          child: Text(
            _sight.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: sightDetailTitleStyle,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.topLeft,
          child: Row(children: [
            Text(
              _sight.category.toString(),
              style: sightDetailCategoryStyle,
            ),
            Container(
              width: 15,
              height: 0,
            ),
            Text(
              closedUntil,
              style: closedUntilStyle,
            ),
          ]),
        ),
      ),
      Expanded(
        flex: 6,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.centerLeft,
          child: Text(
            _sight.details,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: sightDetailStyle,
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.near_me_outlined,
              color: Colors.white,
              size: 30,
            ),
            Container(
              width: 5,
              height: 0,
            ),
            Text(
              buildRoute,
              style: sightDetailBuildRouteStyle,
            ),
          ]),
        ]),
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 4,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.calendar_today_outlined,
              color: tertiaryTextColor,
              size: 24,
            ),
            Container(
              width: 5,
              height: 0,
            ),
            Text(
              toSchedule,
              style: closedUntilStyle,
            ),
            Container(
              width: 30,
              height: 0,
            ),
            Icon(
              Icons.favorite_border,
              color: secondaryTextColor,
              size: 28,
            ),
            Container(
              width: 5,
              height: 0,
            ),
            Text(
              toFavorites,
              style: sightDetailStyle,
            )
          ]),
        ),
      ),
    ]);
  }
}
