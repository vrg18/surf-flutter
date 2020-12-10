import 'package:flutter/material.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/sight_detail.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

import 'mocks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Roboto',
      ),
      home: SightListScreen(firstPortraitScreenTitle),
//      home: SightDetail(mocks[0]),
    );
  }
}
