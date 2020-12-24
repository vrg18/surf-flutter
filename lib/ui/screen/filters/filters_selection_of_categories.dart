import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/filters/filters_category_icon.dart';

/// Верхняя (левая) часть экрана фильтров с выбором категорий
class FiltersSelectionOfCategories extends StatefulWidget {
  @override
  _FiltersSelectionOfCategoriesState createState() => _FiltersSelectionOfCategoriesState();
}

class _FiltersSelectionOfCategoriesState extends State<FiltersSelectionOfCategories> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Column(
        children: [
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: () => print(leaveFiltersPress),
                minWidth: 20,
                child: Icon(
                  Icons.chevron_left,
                  size: 28,
                  color: currentThemeIsDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                ),
              ),
              FlatButton(
                onPressed: () => setState(() {
                  selectedCategories.clear();
                  print(clearFiltersPress);
                }),
                child: Text(
                  clearFilters,
                  style: clearFiltersButtonTextStyle,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: 20),
            width: double.infinity,
            child: Text(
              categoriesFilters,
              style: lowSelectionStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            height: 260,
            child: GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: 80,
              crossAxisSpacing: 32,
              mainAxisSpacing: 16,
              childAspectRatio: .8,
              children: categories.map((e) => FiltersCategoryIcon(e)).toList(),
            ),
          ),
        ],
      );
    });
  }
}
