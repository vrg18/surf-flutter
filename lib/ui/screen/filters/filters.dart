import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/filters/filters_selection_of_categories.dart';
import 'package:places/ui/screen/filters/filters_slider_and_button.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

/// Экран фильтров поиска мест
class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = context.read<CurrentTheme>().isDark;
  }

  @override
  Widget build(BuildContext context) {
    var _numberOfNearbySights = context.watch<SightProvider>().nearbySights.listOfNearbySights.length;

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: _filtersTopBar(_isDark),
        body: orientation == Orientation.portrait
            ? Column(children: [
                Expanded(flex: 4, child: FiltersSelectionOfCategories(orientation)),
                Expanded(flex: 3, child: FiltersSliderAndButton()),
              ])
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: FiltersSelectionOfCategories(orientation)),
                  Expanded(flex: 1, child: FiltersSliderAndButton()),
                ],
              ),
        floatingActionButton: orientation == Orientation.portrait
            ? _getBigGreenButton(_numberOfNearbySights)
            : Row(children: [
                Spacer(),
                Expanded(child: _getBigGreenButton(_numberOfNearbySights)),
              ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  /// AppBar экрана фильтров
  PreferredSizeWidget _filtersTopBar(bool isDark) {
    return TopBar(
      titleHeight: appBarTitleHeight,
      leftButton: UniversalWhiteButton(
        iconData: Icons.chevron_left,
        isDark: _isDark,
        callback: () => Navigator.pop(context, false),
      ),
      rightButton: UniversalWhiteButton(
        label: letteringClear,
        textStyle: clearFiltersButtonTextStyle,
        callback: () => _clearFilters(),
      ),
    );
  }

  /// Метод возвращает большую зеленую кнопку
  Widget _getBigGreenButton(int numberOfNearbySights) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: BigGreenButton(
        label: sprintf(buttonLabelShow, [numberOfNearbySights]),
        isActive: numberOfNearbySights != 0,
        callback: () => Navigator.pop(context, true),
      ),
    );
  }

  /// Метод сбрасывает все фильтры
  _clearFilters() {
    setState(() => context.read<SightProvider>().nearbySights.clearFilters());
  }
}
