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
    var titles = FIRST_SCREEN_TITLE.split('_');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
            toolbarHeight: double.infinity,
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: MAIN_TEXT_COLOR,
                  ),
                  children: [
                    TextSpan(
                        text: titles[0],
                        style: TextStyle(color: Colors.green)),
                    TextSpan(text: titles[1]),
                    TextSpan(
                        text: titles[2],
                        style: TextStyle(color: Colors.yellow)),
                    TextSpan(text: titles[3]),
                    TextSpan(
                        text: titles[4],
                        style: TextStyle(color: Colors.black)),
                    TextSpan(text: titles[5])
                  ]),
            ),
            backgroundColor: Colors.white,
            elevation: 0),
      ),
      body: Center(child: Text(APP_WILL_BE_HERE)),
    );
  }
}
