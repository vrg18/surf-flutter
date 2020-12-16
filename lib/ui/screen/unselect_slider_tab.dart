import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class UnselectSliderTabs extends StatelessWidget {
  final String _tabText;

  UnselectSliderTabs(this._tabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: backgroundColorCardLabel,
      child: Center(
        child: Text(
          _tabText,
          style: closedUntilStyle,
        ),
      ),
    );
  }
}
