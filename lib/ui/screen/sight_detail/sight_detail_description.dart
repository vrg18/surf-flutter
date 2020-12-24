import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';

/// Нижняя (правая) текстовая часть экрана детализации места
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
                  _sight.category.toStringLowerCase(),
                  style: sightDetailCategoryStyle,
                ),
                SizedBox(width: 15),
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
            flex: 3,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: heightOfBigGreenButton),
              child: RaisedButton(
                onPressed: () => print(buildRoutePress),
                color: bigGreenButtonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.near_me_outlined,
                      color: bigGreenButtonLabelColor,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      buildRoute,
                      style: bigGreenButtonTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: lightDarkerBackgroundColor,
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
                            Icons.today,
                            color: currentThemeIsDark ? darkElementTertiaryColor : lightElementTertiaryColor,
                            size: 24,
                          ),
                          SizedBox(width: 5),
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
                            color: currentThemeIsDark ? darkElementPrimaryColor : lightElementSecondaryColor,
                            size: 28,
                          ),
                          SizedBox(width: 5),
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
