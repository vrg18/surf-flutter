import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

/// Обертка для Web-экранов, своеобразный "закос" под телефон для Web
/// Отказался от device_preview, т.к. он не поддерживает null-safety
class WebWrapper extends StatelessWidget {
  final Widget _child;

  WebWrapper(this._child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: constraints.maxWidth < widthWebWrapper || constraints.maxHeight < heightWebWrapper
              ? EdgeInsets.zero
              : const EdgeInsets.all(basicBorderSize),
          color: shellBackgroundColor,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadiusOfShellScreens),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widthWebWrapper,
                  maxHeight: heightWebWrapper,
                ),
                //color: primaryBackgroundColor,
                child: _child,
              ),
            ),
          ),
        );
      },
    );
  }
}
