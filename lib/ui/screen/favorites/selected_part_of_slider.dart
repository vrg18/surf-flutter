import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Виджет выбранной части слайдера экрана Favorites
class SelectedPartOfSlider extends StatelessWidget {
  final String _tabText;

  SelectedPartOfSlider(this._tabText);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<CurrentTheme>().isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? darkElementPrimaryColor : lightElementSecondaryColor,
        borderRadius: BorderRadius.circular(sliderHeightOnScreenFavorites / 2),
      ),
      child: Center(
        child: Text(
          _tabText,
          style: context.watch<CurrentTheme>().isDark
              ? darkSelectTabFavoritesScreenStyle
              : lightSelectTabFavoritesScreenStyle,
        ),
      ),
    );
  }
}
