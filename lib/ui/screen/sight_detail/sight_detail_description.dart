import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/buttons/simple_white_button.dart';
import 'package:provider/provider.dart';

/// Нижняя (правая) текстовая часть экрана детализации места
class SightDetailDescription extends StatelessWidget {
  final Sight _sight;

  SightDetailDescription(this._sight);

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return Container(
      padding: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: basicBorderSize),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: _rowTitle(),
          ),
          Expanded(
            flex: 1,
            child: _rowCategory(_isDark),
          ),
          Expanded(
            flex: 6,
            child: _rowDescription(_isDark),
          ),
          Expanded(
            flex: 3,
            child: _rowBigGreenButton(),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: _rowToScheduleAndFavorite(_isDark),
          ),
        ],
      ),
    );
  }

  /// Строка с названием места
  Widget _rowTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        _sight.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: sightDetailTitleStyle,
      ),
    );
  }

  /// Строка с категорией и часами работы
  Widget _rowCategory(bool isDark) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(children: [
        Text(
          _sight.category.toStringLowerCase(),
          style: isDark ? darkSightDetailCategoryStyle : lightSightDetailCategoryStyle,
        ),
        const SizedBox(width: 15),
        Text(
          letteringClosedUntil,
          style: lightFaintInscriptionStyle,
        ),
      ]),
    );
  }

  /// Строка с подробным описанием места
  Widget _rowDescription(bool isDark) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        _sight.description,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: isDark ? darkSightDetailStyle : lightSightDetailStyle,
      ),
    );
  }

  /// Большая зеленая кнопка
  Widget _rowBigGreenButton() {
    return Center(
      child: BigGreenButton(
        label: buttonLabelBuildRoute,
        iconData: Icons.near_me_outlined,
        toConsole: buildRoutePress,
      ),
    );
  }

  /// Строка с кнопками "Запланировать" и "В избранное"
  Widget _rowToScheduleAndFavorite(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: lightDarkerBackgroundColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SimpleWhiteButton(
            label: buttonLabelToSchedule,
            isDark: isDark,
            isActive: false,
            iconData: Icons.today,
            toConsole: toSchedulePress,
          ),
          SimpleWhiteButton(
            label: buttonLabelToFavorites,
            isDark: isDark,
            iconData: Icons.favorite_border,
            toConsole: toFavoritesPress,
          ),
        ],
      ),
    );
  }
}
