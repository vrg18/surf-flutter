import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

class BigGreenButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData? iconData;
  final String? textToConsole;

  BigGreenButton({
    required this.label,
    this.isActive = true,
    this.iconData,
    this.textToConsole,
  });

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return SizedBox(
      height: heightOfBigGreenButton,
      width: double.infinity,
      child: RaisedButton(
        onPressed: () => {if (textToConsole != null) print(textToConsole)},
        color: isActive ? bigGreenButtonColor : _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(
                    iconData,
                    color: isActive ? bigGreenButtonLabelColor : lightElementTertiaryColor,
                    size: 30,
                  )
                : const SizedBox.shrink(),
            iconData != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
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
