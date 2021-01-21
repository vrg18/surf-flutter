import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/filters/filters_selection_of_categories.dart';
import 'package:places/ui/screen/filters/filters_slider_and_button.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

/// Экран фильтров поиска мест
class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<CurrentTheme>().isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;
    var _numberOfNearbySights = context.watch<NearbySights>().listOfNearbySights.length;

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: TopBar(
          titleHeight: 0,
          bottomHeight: 50,
          title: const SizedBox.shrink(),
          bottom: _filtersTopBar(_isDark),
        ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }

  /// AppBar экрана фильтров
  Widget _filtersTopBar(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: () => print(leaveFiltersPress),
          minWidth: 20,
          child: Icon(
            Icons.chevron_left,
            size: 28,
            color: isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
          ),
        ),
        FlatButton(
          onPressed: () => setState(() {
            context.read<NearbySights>().selectedCategories.clear();
            context.read<NearbySights>().startOfSearchRadius = distanceValueFrom;
            context.read<NearbySights>().endOfSearchRadius = distanceValueUp;
          }),
          child: Text(
            letteringClear,
            style: clearFiltersButtonTextStyle,
          ),
        ),
      ],
    );
  }

  /// Метод возвращает большую зеленую кнопку
  Padding _getBigGreenButton(int numberOfNearbySights) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: BigGreenButton(
        label: sprintf(buttonLabelShow, [numberOfNearbySights]),
        isActive: numberOfNearbySights != 0,
        toConsole: applyFiltersPress,
      ),
    );
  }
}
