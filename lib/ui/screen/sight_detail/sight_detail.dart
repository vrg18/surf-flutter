import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_detail/sight_detail_description.dart';
import 'package:places/ui/screen/sight_detail/sight_detail_photo.dart';
import 'package:provider/provider.dart';

/// Экран детализации места
class SightDetail extends StatelessWidget {
  final Sight _sight;

  SightDetail(this._sight);

  @override
  Widget build(BuildContext context) {
    bool _isDark = context.watch<CurrentTheme>().isDark;

    return OrientationBuilder(
      builder: (context, orientation) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                orientation == Orientation.portrait || _isDark ? Brightness.light : Brightness.dark,
          ),
        );
        return LayoutBuilder(
          builder: (_, constraints) {
            int itemCount = _sight.photos.length;
            double indicatorWidth = orientation == Orientation.portrait
                ? constraints.maxWidth / itemCount
                : constraints.maxWidth / itemCount / 2;

            return Scaffold(
              body: orientation == Orientation.portrait
                  ? Column(children: [
                      Expanded(child: SightDetailPhoto(_sight.photos, indicatorWidth)),
                      Expanded(child: SightDetailDescription(_sight)),
                    ])
                  : Row(children: [
                      Expanded(child: SightDetailPhoto(_sight.photos, indicatorWidth)),
                      Expanded(child: SightDetailDescription(_sight)),
                    ]),
            );
          },
        );
      },
    );
  }
}
