import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

/// Универсальная (иконка и/или текст) белая кнопка
class UniversalWhiteButton extends StatelessWidget {
  final String? label;
  final bool? isDark;
  final bool isActive;
  final IconData? iconData;
  final TextStyle? textStyle;
  final VoidCallback? callback;
  final bool skipFocus;
  final String? toConsole;

  UniversalWhiteButton({
    this.label,
    this.isDark,
    this.isActive = true,
    this.iconData,
    this.textStyle,
    this.callback,
    this.skipFocus = false,
    this.toConsole,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isActive
          ? () {
              if (toConsole != null) print(toConsole);
              if (callback != null && isActive) callback!();
            }
          : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.minPositive,
          double.minPositive,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      //minWidth: label == null ? 20 : null,
      focusNode: skipFocus ? FocusNode(skipTraversal: true) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: _iconColor(),
              size: label != null ? 24 : 28,
            ),
          if (iconData != null && label != null) const SizedBox(width: 5),
          if (label != null)
            Text(
              label!,
              style: _buttonTextStyle(),
            ),
        ],
      ),
    );
  }

  /// Цвет иконки в зависимости от стиля, активности и темной/светлой тем
  Color _iconColor() {
    if (textStyle != null)
      return textStyle!.color!;
    else if (isActive && !isDark!)
      return lightElementSecondaryColor;
    else if (isActive && isDark!)
      return darkElementPrimaryColor;
    else if (!isActive && !isDark!)
      return lightElementTertiaryColor;
    else
      return darkElementTertiaryColor;
  }

  /// Стиль текста кнопки в зависимости от переданного стиля или активности и темной/светлой тем
  TextStyle _buttonTextStyle() {
    if (textStyle != null)
      return textStyle!;
    else if (!isActive)
      return lightFaintInscriptionStyle;
    else if (!isDark!)
      return lightSightDetailStyle;
    else
      return darkSightDetailStyle;
  }
}
