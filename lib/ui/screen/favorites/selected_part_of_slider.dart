import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';

/// Виджет выбранной части слайдера экрана Favorites
class SelectedPartOfSlider extends StatelessWidget {
  final String _tabText;

  SelectedPartOfSlider(this._tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentThemeIsDark ? dmElementPrimaryColor : lmElementSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(sliderHeightOnScreenFavorites / 2)),
      ),
      child: Center(
        child: Text(
          _tabText,
          style: selectTabFavoritesScreenStyle,
        ),
      ),
    );
  }
}
