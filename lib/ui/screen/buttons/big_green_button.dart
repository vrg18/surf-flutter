import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Большая зеленая кнопка
class BigGreenButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData? iconData;
  final VoidCallback? callback;
  final String? toConsole;

  BigGreenButton({
    required this.label,
    this.isActive = true,
    this.iconData,
    this.callback,
    this.toConsole,
  });

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return SizedBox(
      height: heightOfBigGreenButton,
      width: double.infinity,
      child: RaisedButton(
        onPressed: isActive
            ? () {
                if (toConsole != null) print(toConsole);
                if (callback != null && isActive) callback!();
              }
            : null,
        color: bigGreenButtonColor,
        disabledColor: _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: isActive ? bigGreenButtonLabelColor : lightElementTertiaryColor,
                size: 30,
              ),
            if (iconData != null) const SizedBox(width: 5),
            Text(
              label,
              style: isActive ? activeBigGreenButtonTextStyle : passiveBigGreenButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
