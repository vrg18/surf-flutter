import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

class ShellScreens extends StatelessWidget {
  final Widget _child;

  ShellScreens(this._child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: constraints.maxWidth < wideScreenSizeOver ? EdgeInsets.zero : const EdgeInsets.all(basicBorderSize),
          color: shellBackgroundColor,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadiusOfShellScreens),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: wideScreenSizeOver,
                ),
//                color: primaryBackgroundColor,
                child: _child,
              ),
            ),
          ),
        );
      },
    );
  }
}
