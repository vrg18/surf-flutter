import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/filters/filters_category_icon.dart';
import 'package:provider/provider.dart';

/// Верхняя (левая) часть экрана фильтров с выбором категорий
class FiltersSelectionOfCategories extends StatefulWidget {
  final Orientation _orientation;

  FiltersSelectionOfCategories(this._orientation);

  @override
  _FiltersSelectionOfCategoriesState createState() => _FiltersSelectionOfCategoriesState();
}

class _FiltersSelectionOfCategoriesState extends State<FiltersSelectionOfCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: 20),
          width: double.infinity,
          child: Text(
            letteringCategories,
            style: context.watch<CurrentTheme>().isDark ? darkFaintInscriptionStyle : lightFaintInscriptionStyle,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40, top: basicBorderSize, bottom: basicBorderSize),
          height: widget._orientation == Orientation.portrait
              ? heightOfCategorySelectionListForPortrait
              : heightOfCategorySelectionListForLandscape,
          child: GridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: 80,
            crossAxisSpacing: 32,
            mainAxisSpacing: widget._orientation == Orientation.portrait ? 16 : 8,
            childAspectRatio: .8,
            children: categories.map((e) => FiltersCategoryIcon(e)).toList(),
          ),
        ),
      ],
    );
  }
}
