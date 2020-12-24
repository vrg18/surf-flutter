import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/filters/filters_selection_of_categories.dart';
import 'package:places/ui/screen/filters/filters_slider_and_button.dart';

/// Экран фильтров поиска мест
class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: currentThemeIsDark ? Brightness.light : Brightness.dark,
        ),
      );
      return Scaffold(
        body: orientation == Orientation.portrait
            ? Column(children: [
                Expanded(flex: 4, child: FiltersSelectionOfCategories()),
                Expanded(flex: 3, child: FiltersSliderAndButton()),
              ])
            : Row(children: [
                Expanded(flex: 1, child: FiltersSelectionOfCategories()),
                Expanded(flex: 1, child: FiltersSliderAndButton()),
              ]),
      );
    });
  }
}
