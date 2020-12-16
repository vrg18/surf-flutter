import 'package:flutter/material.dart';

/// Виджет кастомного верхнего бара, альтернатива AppBar
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Color backgroundColor;
  final bool centerTextHorizontally;
  final Text title;

  const TopBar({
    Key? key,
    required this.height,
    required this.backgroundColor,
    this.centerTextHorizontally = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: centerTextHorizontally ? Alignment.center : Alignment.centerLeft,
        height: height,
        color: backgroundColor,
        child: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
