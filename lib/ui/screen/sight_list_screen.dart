import 'package:flutter/material.dart';
import 'package:places/texts.dart' as Texts;

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
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text(Texts.APP_WILL_BE_HERE),
      ),
    );
  }
}
