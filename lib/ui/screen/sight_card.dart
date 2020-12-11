import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  Sight sight;

  SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(children: [
          Column(children: [
            Expanded(
              child: SizedBox.expand(
                child: Image.network(
                  sight.url,
                  fit: BoxFit.cover,
                ),
              ),
              flex: 3,
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                color: backgroundColorCardLabel,
                child: Text(
                  sight.nameSight,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: sightCardTitleStyle,
                ),
              ),
              flex: 1,
            ),
          ]),
          Positioned(
            left: 15,
            top: 15,
            child: Text(
              sight.type.toString(),
              style: sightCardCategoryStyle,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ),
        ]),
      ),
    );
  }
}
