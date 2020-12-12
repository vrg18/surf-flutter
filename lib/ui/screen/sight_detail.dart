import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_detail_description.dart';
import 'package:places/ui/screen/sight_detail_photo.dart';

class SightDetail extends StatelessWidget {
  Sight sight;

  SightDetail(this.sight);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: orientation == Orientation.portrait
            ? Column(children: [
                Expanded(child: SightDetailPhoto(sight.url)),
                Expanded(child: SightDetailDescription(sight)),
              ])
            : Row(children: [
                Expanded(child: SightDetailPhoto(sight.url)),
                Expanded(child: SightDetailDescription(sight)),
              ]),
      );
    });
  }
}