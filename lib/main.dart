import 'package:flutter/material.dart';
import 'package:places/app_texts.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Roboto',
      ),
      home: SightListScreen(FIRST_SCREEN_TITLE),
    );
  }
}
