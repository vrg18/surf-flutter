import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';

/// Виджет выбранной части слайдера экрана Favorites
class SelectedPartOfSlider extends StatelessWidget {
  final String _tabText;

  SelectedPartOfSlider(this._tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryTextColor,
        borderRadius: BorderRadius.all(Radius.circular(sliderHeightOnScreenFavorites / 2)),
      ),
      child: Center(
        child: Text(
          _tabText,
          style: selectTabfavoritesScreenStyle,
        ),
      ),
    );
  }
}
