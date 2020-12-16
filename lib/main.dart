import 'package:flutter/material.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/bottom_bar.dart';
import 'package:places/ui/screen/sight_detail.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/favorites.dart';

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
//      home: SightList(),
//      home: SightDetail(mocks[0]),
//      home: Favorites(),
        home: BottomBar(),
    );
  }
}
