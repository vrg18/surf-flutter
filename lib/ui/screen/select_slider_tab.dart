import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SelectSliderTabs extends StatelessWidget {
  final String _tabText;

  SelectSliderTabs(this._tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryTextColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Center(
        child: Text(
          _tabText,
          style: selectTabfavoritesScreenStyle,
        ),
      ),
    );
  }
}
