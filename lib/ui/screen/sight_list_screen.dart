import 'package:flutter/material.dart';
import 'package:places/texts.dart';

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
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3B3E5B)),
                  children: [
                    TextSpan(
                        text: FIRST_SCREEN_TITLE_1,
                        style: TextStyle(color: Colors.green)),
                    TextSpan(text: FIRST_SCREEN_TITLE_2),
                    TextSpan(
                        text: FIRST_SCREEN_TITLE_3,
                        style: TextStyle(color: Colors.yellow)),
                    TextSpan(text: FIRST_SCREEN_TITLE_4),
                    TextSpan(
                        text: FIRST_SCREEN_TITLE_5,
                        style: TextStyle(color: Colors.black)),
                    TextSpan(text: FIRST_SCREEN_TITLE_6)
                  ]),
            ),
            backgroundColor: Colors.white,
            elevation: 0),
      ),
      body: Center(child: Text(APP_WILL_BE_HERE)),
    );
  }
}
