import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  Sight sight;

  SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              color: background_color_card_label,
              child: Text(
                sight.nameSight,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: SIGHT_CARD_TITLE_STYLE,
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
            style: SIGHT_CARD_CATEGORY_STYLE,
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
    );
  }
}
