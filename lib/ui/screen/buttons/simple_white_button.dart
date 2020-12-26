import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SimpleWhiteButton extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool isActive;
  final IconData? iconData;
  final String? textToConsole;

  SimpleWhiteButton({
    required this.label,
    required this.isDark,
    this.isActive = true,
    this.iconData,
    this.textToConsole,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: () => {if (textToConsole != null) print(textToConsole)},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(
                    iconData,
                    color: _buttonColor(),
                    size: 24,
                  )
                : const SizedBox.shrink(),
            iconData != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
            Text(
              label,
              style: _buttonTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Color _buttonColor() {
    if (isActive && !isDark)
      return lightElementSecondaryColor;
    else if (isActive && isDark)
      return darkElementPrimaryColor;
    else if (!isActive && !isDark)
      return lightElementTertiaryColor;
    else
      return darkElementTertiaryColor;
  }

  TextStyle _buttonTextStyle() {
    if (!isActive)
      return lightFaintInscriptionStyle;
    else if (!isDark)
      return lightSightDetailStyle;
    else
      return darkSightDetailStyle;
  }
}
