import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

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
    _selectedCategory = context.watch<NearbySights>().selectedCategories.contains(_category);
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Stack(
            children: [
              _roundButton(context),
              if (_selectedCategory)
                Positioned(
                  right: 8,
                  bottom: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: context.watch<CurrentTheme>().isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                    size: 20,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            widget._category.toString(),
            style:
                context.watch<CurrentTheme>().isDark ? darkCategoryIconLabelTextStyle : lightCategoryIconLabelTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Виджет-кнопка категории
  Widget _roundButton(BuildContext context) {
    return RawMaterialButton(
      fillColor:
          context.watch<CurrentTheme>().isDark ? darkCategoryIconsBackgroundColor : lightCategoryIconsBackgroundColor,
      shape: CircleBorder(),
      padding: const EdgeInsets.all(16),
      elevation: 0,
      onPressed: () => setState(() {
        if (_selectedCategory) {
          _selectedCategory = false;
          context.read<NearbySights>().selectedCategories.remove(_category);
        } else {
          _selectedCategory = true;
          context.read<NearbySights>().selectedCategories.add(_category);
        }
        context.read<NearbySights>().fillListOfNearbySights();
      }),
      child: Icon(
        widget._category.icon,
        color: bigGreenButtonColor,
        size: 32,
      ),
    );
  }
}
