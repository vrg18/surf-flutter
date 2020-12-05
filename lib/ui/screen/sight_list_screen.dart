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
          title: Text(widget.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Center(child: Text(APP_WILL_BE_HERE)),
    );
  }
}
