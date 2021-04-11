import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

/// Обертка для Web-экранов, своеобразный "закос" под телефон для Web
class WebWrapper extends StatelessWidget {
  final Widget child;

  const WebWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth < widthWebWrapper ? 0 : basicBorderSize,
            vertical: constraints.maxHeight < heightWebWrapper ? 0 : basicBorderSize,
          ),
          color: wrapperBackgroundColor,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusOfWebWrapper),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widthWebWrapper,
                  maxHeight: heightWebWrapper,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
