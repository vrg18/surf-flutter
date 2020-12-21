import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';

/// Виджет невыбранной части слайдера экрана Favorites
class UnselectedPartOfSlider extends StatelessWidget {
  final String _tabText;

  UnselectedPartOfSlider(this._tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: currentThemeIsDark ? dmDarkerBackgroundColor : lmDarkerBackgroundColor,
      child: Center(
        child: Text(
          _tabText,
          style: lowSelection700Style,
        ),
      ),
    );
  }
}
