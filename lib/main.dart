import 'package:flutter/material.dart';
import 'package:places/texts.dart' as Texts;
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Texts.APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Roboto',
      ),
      home: SightListScreen(Texts.FIRST_SCREEN_TITLE),
    );
  }
}
