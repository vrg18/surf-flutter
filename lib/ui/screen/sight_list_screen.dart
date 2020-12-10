import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'my_app_bar.dart';

class SightListScreen extends StatefulWidget {
  final String title;

  SightListScreen(this.title);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
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
              constraints: BoxConstraints(maxWidth: 450), // ограничение для горизонтальной ориентации экрана
                                                          // в будущем сделаю сетку шириной 1 или 2 от ориентации
              child: Column(children: mocks.map((e) => SightCard(e)).toList())),
        ),
      );
    });
  }
}
