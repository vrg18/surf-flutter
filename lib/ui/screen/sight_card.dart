import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Виджет карточки места нобольшого размера для Списка мест и Избранного
class SightCard extends StatelessWidget {
  final Sight _sight;

  SightCard(this._sight);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<CurrentTheme>().isDark;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  SizedBox.expand(
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
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Text(
                      _sight.category.toStringLowerCase(),
                      style: sightCardCategoryStyle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  _sight.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: sightCardTitleStyle,
                ),
              ),
            ),
          ]),
          Positioned.fill(
            child: MaterialButton(
              onPressed: () => print(sightCardPress),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: MaterialButton(
              onPressed: () => print(toFavoritesOnPhotoPress),
              minWidth: 50,
              height: 50,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
