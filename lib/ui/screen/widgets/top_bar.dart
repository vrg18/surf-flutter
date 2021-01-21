import 'package:flutter/material.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double titleHeight;
  final Widget? title;
  final Widget? leftButton;
  final Widget? rightButton;
  final double? bottomHeight;
  final Widget? bottom;

  const TopBar({
    Key? key,
    required this.titleHeight,
    this.title,
    this.leftButton,
    this.rightButton,
    this.bottomHeight,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(children: [
        SizedBox(
          height: titleHeight,
          child: Stack(
            children: [
              if (title != null)
                Center(
                  child: title,
                ),
              if (leftButton != null) Positioned(left: 0, child: SizedBox(height: titleHeight, child: leftButton!)),
              if (rightButton != null) Positioned(right: 0, child: SizedBox(height: titleHeight, child: rightButton!)),
            ],
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
  Size get preferredSize => Size.fromHeight(titleHeight + (bottomHeight != null ? bottomHeight! : 0));
}
