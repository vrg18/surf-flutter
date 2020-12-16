import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'top_bar.dart';

class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: TopBar(
          height: orientation == Orientation.portrait ? 100 : 55,
          backgroundColor: Colors.white,
          title: Text(
            orientation == Orientation.portrait ? firstPortraitScreenTitle : firstLandscapeScreenTitle,
            style: screenTitleStyle,
            maxLines: orientation == Orientation.portrait ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              // todo ограничение для горизонтальной ориентации экрана, потом сделать сетку шириной 1 или 2 в зависимости от ориентации
              constraints: BoxConstraints(maxWidth: 450),
              child: Column(children: mocks.map((e) => SightCard(e)).toList())),
        ),
      );
    });
  }
}
