import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/shell_screens.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
import 'package:provider/provider.dart';

/// Виджет карточки места небольшого размера для Списка мест и Избранного
class SightCard extends StatelessWidget {
  final Sight sight;
  final IconData? cornerIcon;
  final Function(Sight)? callback;

  SightCard({
    required this.sight,
    this.cornerIcon,
    this.callback,
  });

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => context.read<Web>().isWeb ? ShellScreens(SightDetail(sight)) : SightDetail(sight),
                ),
              ),
            ),
          ),
          if (cornerIcon != null) _buttonAndIconToFavorites(),
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
              sight.url,
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
              sight.category.toStringLowerCase(),
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
          sight.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: sightCardTitleStyle,
        ),
      ),
    );
  }

  /// Кнопка в правом верхнем углу карточки
  Widget _buttonAndIconToFavorites() {
    return Positioned(
      right: 0,
      top: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
        child: MaterialButton(
          onPressed: () {
            print(cornerIconPress);
            if (callback != null) callback!(sight);
          },
          minWidth: 50,
          height: 50,
          child: Icon(
            cornerIcon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
