import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
import 'package:provider/provider.dart';

/// Виджет карточки места нобольшого размера для Списка мест и Избранного
class SightCard extends StatelessWidget {
  final Sight _sight;

  SightCard(this._sight);

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              _topWithPhoto(),
              _photoCaption(),
            ],
          ),
          Positioned.fill(
            child: MaterialButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SightDetail(_sight))),
            ),
          ),
          _buttonAndIconToFavorites(),
        ],
      ),
    );
  }

  /// Верхняя часть карточки с фото
  Widget _topWithPhoto() {
    return Expanded(
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
    );
  }

  /// Нижняя част карточки с наименованием места
  Widget _photoCaption() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        alignment: Alignment.centerLeft,
        child: Text(
          _sight.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: sightCardTitleStyle,
        ),
      ),
    );
  }

  /// Кнопка "В избранное"
  Widget _buttonAndIconToFavorites() {
    return Positioned(
      right: 0,
      top: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
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
    );
  }
}
