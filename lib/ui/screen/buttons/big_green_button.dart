import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';

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
    return SizedBox(
      height: heightOfBigGreenButton,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isActive
            ? () {
                if (toConsole != null) print(toConsole);
                if (callback != null && isActive) callback!();
              }
            : null,
        style: ElevatedButton.styleFrom(
          primary: bigGreenButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        //disabledColor: _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
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
