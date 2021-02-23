import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/sight_provider.dart';
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(basicBorderSize),
            // height: widget._orientation == Orientation.portrait
            //     ? heightOfCategorySelectionListForPortrait
            //     : heightOfCategorySelectionListForLandscape,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                // shrinkWrap: true,
                // maxCrossAxisExtent: 90,
                // crossAxisSpacing: 20,
                // mainAxisSpacing: widget._orientation == Orientation.portrait ? 8 : 8,
                // childAspectRatio: .75,
                children: context
                    .read<SightProvider>()
                    .nearbySights
                    .listOfCategories
                    .map((e) => FiltersCategoryIcon(e))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
