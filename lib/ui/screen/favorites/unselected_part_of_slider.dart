import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Виджет невыбранной части слайдера экрана Favorites
class UnselectedPartOfSlider extends StatelessWidget {
  final String _tabText;

  UnselectedPartOfSlider(this._tabText);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<CurrentTheme>().isDark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
      child: Center(
        child: Text(
          _tabText,
          style: lowSelection700Style,
        ),
      ),
    );
  }
}
