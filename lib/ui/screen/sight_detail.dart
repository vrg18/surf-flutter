import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/app_colors.dart';
import 'package:places/app_styles.dart';
import 'package:places/app_texts.dart';
import 'package:places/domain/sight.dart';

class SightDetail extends StatelessWidget {
  Sight sight;

  SightDetail(this.sight);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 19,
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                sight.url,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                Icons.chevron_left,
                color: MAIN_TEXT_COLOR,
                size: 28,
              ),
            )
          ],
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.bottomLeft,
          child: Text(
            sight.nameSight,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: SIGHT_DETAIL_TITLE_STYLE,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                sight.type.toString(),
                style: SIGHT_DETAIL_CATEGORY_STYLE,
              ),
              Container(
                width: 15,
                height: 0,
              ),
              Text(
                CLOSED_UNTIL,
                style: CLOSED_UNTIL_STYLE,
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          alignment: Alignment.centerLeft,
          child: Text(
            sight.details,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: SIGHT_DETAIL_STYLE,
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  BUILD_ROUTE,
                  style: SIGHT_DETAIL_BUILD_ROUTE_STYLE,
                )
              ],
            )
          ],
        ),
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
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: TERTIARY_LABEL_COLOR,
                size: 24,
              ),
              Container(
                width: 5,
                height: 0,
              ),
              Text(
                TO_SCHEDULE,
                style: CLOSED_UNTIL_STYLE,
              ),
              Container(
                width: 30,
                height: 0,
              ),
              Icon(
                Icons.favorite_border,
                color: SECONDARY_LABEL_COLOR,
                size: 28,
              ),
              Container(
                width: 5,
                height: 0,
              ),
              Text(
                TO_FAVORITES,
                style: SIGHT_DETAIL_STYLE,
              )
            ],
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(),
      ),
    ]));
  }
}
