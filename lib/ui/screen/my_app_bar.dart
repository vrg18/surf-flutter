import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Color backgroundColor;
  final Text title;

  const MyAppBar({
    Key? key,
    required this.height,
    required this.backgroundColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerLeft,
        height: height,
        color: backgroundColor,
        child: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
