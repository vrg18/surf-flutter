import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/filters/filters_selection_of_categories.dart';
import 'package:places/ui/screen/filters/filters_slider_and_button.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран фильтров поиска мест
class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return OrientationBuilder(builder: (context, orientation) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
        ),
      );
      return Scaffold(
        appBar: TopBar(
          titleHeight: 0,
          bottomHeight: 50,
          title: const SizedBox.shrink(),
          bottom: _filtersTopBar(_isDark),
        ),
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
}
