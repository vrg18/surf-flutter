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
    var portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        height: portrait ? 100 : 55,
        backgroundColor: Colors.white,
        title: Text(
          portrait ? first_screen_title : app_title,
          style: SCREEN_TITLE_STYLE,
          maxLines: portrait ? 2 : 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500), // ограничение для горизонтальной ориентации экрана
            child: Column(children: mocks.map((e) => SightCard(e)).toList())),
      ),
    );
  }
}
