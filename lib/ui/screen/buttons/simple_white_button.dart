import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

/// Простая белая кнопка
class SimpleWhiteButton extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool isActive;
  final IconData? iconData;
  final String? toConsole;

  SimpleWhiteButton({
    required this.label,
    required this.isDark,
    this.isActive = true,
    this.iconData,
    this.toConsole,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: isActive ? () => {if (toConsole != null) print(toConsole)} : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: _buttonColor(),
              size: 24,
            ),
          if (iconData != null) const SizedBox(width: 5),
          Text(
            label,
            style: _buttonTextStyle(),
          ),
        ],
      ),
    );
  }

  /// Цвет кнопки в зависимости от активности и темной/светлой тем
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

  /// Стиль текста кнопки в зависимости от активности и темной/светлой тем
  TextStyle _buttonTextStyle() {
    if (!isActive)
      return lightFaintInscriptionStyle;
    else if (!isDark)
      return lightSightDetailStyle;
    else
      return darkSightDetailStyle;
  }
}
