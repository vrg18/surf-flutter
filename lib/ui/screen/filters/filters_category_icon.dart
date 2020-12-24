import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';

class FiltersCategoryIcon extends StatefulWidget {
  final Category _category;

  FiltersCategoryIcon(this._category);

  @override
  _FiltersCategoryIconState createState() => _FiltersCategoryIconState(_category);
}

class _FiltersCategoryIconState extends State<FiltersCategoryIcon> {
  late Category _category;
  late bool _selectedCategory;

  _FiltersCategoryIconState(this._category);

  @override
  Widget build(BuildContext context) {
    _selectedCategory = selectedCategories.contains(_category);
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Stack(
            children: [
              RawMaterialButton(
                fillColor: currentThemeIsDark ? darkCategoryIconsBackgroundColor : lightCategoryIconsBackgroundColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
                elevation: 0,
                onPressed: () => setState(() {
                  if (_selectedCategory) {
                    _selectedCategory = false;
                    selectedCategories.remove(_category);
                  } else {
                    _selectedCategory = true;
                    selectedCategories.add(_category);
                  }
                }),
                child: Icon(
                  widget._category.icon,
                  color: bigGreenButtonColor,
                  size: 32,
                ),
              ),
              _selectedCategory
                  ? Positioned(
                      right: 8,
                      bottom: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: currentThemeIsDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                        size: 20,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 10),
          Text(
            widget._category.toString(),
            style: categoryIconLabelTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
