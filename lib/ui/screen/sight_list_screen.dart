import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  final String title;

  SightListScreen(this.title);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
            toolbarHeight: double.infinity,
            title: Text(
              first_screen_title,
              style: SCREEN_TITLE_STYLE,
            ),
            backgroundColor: Colors.white,
            elevation: 0),
      ),
      body: SingleChildScrollView(
        child: Column(children: mocks.map((e) => SightCard(e)).toList()),
      ),
    );
  }
}
