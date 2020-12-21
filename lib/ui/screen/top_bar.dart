import 'package:flutter/material.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double titleHeight;
  final double bottomHeight;
  final Text title;
  final Widget bottom;

  const TopBar({
    Key? key,
    required this.titleHeight,
    required this.bottomHeight,
    required this.title,
    required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: true,
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          height: titleHeight,
          child: title,
        ),
        Container(
          alignment: Alignment.center,
          height: bottomHeight,
          child: bottom,
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(titleHeight + bottomHeight);
}
