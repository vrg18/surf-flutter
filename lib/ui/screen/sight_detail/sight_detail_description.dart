import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Нижняя (правая) текстовая часть экрана детализации места
class SightDetailDescription extends StatelessWidget {
  final Sight _sight;

  SightDetailDescription(this._sight);

  @override
  Widget build(BuildContext context) {
    bool _isDark = context.watch<CurrentTheme>().isDark;

    return Padding(
      padding: const EdgeInsets.all(basicBorderSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _rowTitle(),
          const SizedBox(height: 12),
          _rowCategory(_isDark),
          const SizedBox(height: 24),
          _rowDescription(_isDark),
        ],
      ),
    );
  }

  /// Строка с названием места
  Widget _rowTitle() {
    return Text(
      _sight.name,
      style: sightDetailTitleStyle,
    );
  }

  /// Строка с категорией и часами работы
  Widget _rowCategory(bool isDark) {
    return Row(children: [
      Text(
        _sight.category.toStringLowerCase(),
        style: isDark ? darkSightDetailCategoryStyle : lightSightDetailCategoryStyle,
      ),
      const SizedBox(width: 16),
      Text(
        letteringClosedUntil,
        style: lightFaintInscriptionStyle,
      ),
    ]);
  }

  /// Текст с подробным описанием места
  Widget _rowDescription(bool isDark) {
    return Text(
      _sight.description,
//        overflow: TextOverflow.fade,
      style: isDark ? darkSightDetailStyle : lightSightDetailStyle,
    );
  }
}
