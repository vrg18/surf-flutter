import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';

class BigGreenButton extends StatelessWidget {
  final String label;
  final IconData? iconData;
  final String? textToConsole;

  BigGreenButton({
    required this.label,
    this.iconData,
    this.textToConsole,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfBigGreenButton,
      width: double.infinity,
      child: RaisedButton(
        onPressed: () => {if (textToConsole != null) print(textToConsole)},
        color: bigGreenButtonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(
                    iconData,
                    color: bigGreenButtonLabelColor,
                    size: 30,
                  )
                : const SizedBox.shrink(),
            iconData != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
            Text(
              label,
              style: bigGreenButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
