import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';

/// Виджет - текстовая часть экрана детализации места
class SightDetailDescription extends StatelessWidget {
  final Sight _sight;

  SightDetailDescription(this._sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: basicBorderSize),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _sight.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: sightDetailTitleStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
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
                  style: lowSelectionStyle,
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
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
            flex: 2,
            child: RaisedButton(
              onPressed: () => print(buildRoutePress),
              color: buildRouteButtonColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.near_me_outlined,
                    color: buildRouteButtonTextColor,
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: lmDarkerBackgroundColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () => print(toSchedulePress),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: currentThemeIsDark ? dmElementTertiaryColor : lmElementTertiaryColor,
                            size: 24,
                          ),
                          Container(
                            width: 5,
                            height: 0,
                          ),
                          Text(
                            toSchedule,
                            style: lowSelectionStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () => print(toFavoritesPress),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: currentThemeIsDark ? dmElementPrimaryColor : lmElementSecondaryColor,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
