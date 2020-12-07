import 'package:flutter/material.dart';
import 'package:places/app_colors.dart';
import 'package:places/app_texts.dart';

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
              FIRST_SCREEN_TITLE,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: MAIN_TEXT_COLOR,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0),
      ),
      body: Center(child: Text(APP_WILL_BE_HERE)),
    );
  }
}
