import 'package:flutter/material.dart';
import 'package:places/ui/res/sizes.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double titleHeight;
  final Widget? title;
  final Widget? leftButton;
  final Widget? rightButton;
  final double? bottomHeight;
  final Widget? bottom;
  final bool? isWeb;

  TopBar({
    Key? key,
    required this.titleHeight,
    this.title,
    this.leftButton,
    this.rightButton,
    this.bottomHeight,
    this.bottom,
    this.isWeb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _additionalPaddingAboveTopBar = isWeb != null && isWeb! ? additionalPaddingAboveTopBar : 0;
    double _additionalPaddingsForWeb = isWeb != null && isWeb! ? additionalPaddingsForWeb : 0;

    return SafeArea(
      top: true,
      bottom: false,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
            top: _additionalPaddingAboveTopBar,
            left: _additionalPaddingsForWeb,
            right: _additionalPaddingsForWeb,
          ),
          child: SizedBox(
            height: titleHeight,
            child: Stack(
              children: [
                if (title != null)
                  Center(
                    child: title,
                  ),
                if (leftButton != null)
                  Positioned(
                    left: 0,
                    child: SizedBox(
                      height: heightOfBigGreenButton,
                      child: leftButton!,
                    ),
                  ),
                if (rightButton != null)
                  Positioned(
                      right: 0,
                      child: SizedBox(
                        height: heightOfBigGreenButton,
                        child: rightButton!,
                      )),
              ],
            ),
          ),
        ),
        if (bottomHeight != null && bottom != null)
          Container(
            alignment: Alignment.center,
            height: bottomHeight!,
            child: bottom!,
          ),
      ]),
    );
  }

  /// Переопределяем метод, возвращающий виджет Size высотой равной высоте нашего аппбара
  @override
  Size get preferredSize => Size.fromHeight((isWeb != null && isWeb! ? additionalPaddingAboveTopBar : 0) +
      titleHeight +
      (bottomHeight != null ? bottomHeight! : 0));
}
