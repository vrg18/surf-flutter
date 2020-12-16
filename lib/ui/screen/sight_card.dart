import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

/// Виджет карточки места нобольшого размера для Списка мест и Избранного
class SightCard extends StatelessWidget {
  final Sight _sight;

  SightCard(this._sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Stack(children: [
        Column(children: [
          Expanded(
            child: SizedBox.expand(
              child: Image.network(
                _sight.url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              color: backgroundColorCardLabel,
              child: Text(
                _sight.name,
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
            _sight.category.toString(),
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
    );
  }
}
