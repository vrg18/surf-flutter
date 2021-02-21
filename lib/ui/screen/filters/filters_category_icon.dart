import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/domain/category.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

class FiltersCategoryIcon extends StatefulWidget {
  final Category _category;

  FiltersCategoryIcon(this._category);

  @override
  _FiltersCategoryIconState createState() => _FiltersCategoryIconState();
}

class _FiltersCategoryIconState extends State<FiltersCategoryIcon> {
  late bool _selectedCategory;

  @override
  Widget build(BuildContext context) {
    _selectedCategory = context.watch<SightProvider>().nearbySights.selectedCategories.contains(widget._category);
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
          context.read<SightProvider>().nearbySights.selectedCategories.remove(widget._category);
        } else {
          _selectedCategory = true;
          context.read<SightProvider>().nearbySights.selectedCategories.add(widget._category);
        }
        context.read<SightProvider>().fillListOfNearbySights();
      }),
      child: Icon(
        widget._category.icon,
        color: bigGreenButtonColor,
        size: 32,
      ),
    );
  }
}
