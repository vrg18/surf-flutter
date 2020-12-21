import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/main_screen_with_bottom_bar.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/favorites/favorites.dart';

import 'mocks.dart';

main() => runApp(
      DevicePreview(
        enabled: isWeb(),
        defaultDevice: Devices.android.samsungS20,
        isToolbarVisible: true,
        builder: (context) => MyApp(),
      ),
    );

bool isWeb() {
  bool _isWeb;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      _isWeb = false;
    } else {
      _isWeb = true;
    }
  } catch (e) {
    _isWeb = true;
  }
  return _isWeb;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: appTitle,
      theme: currentThemeIsDark ? darkTheme : lightTheme,
//      home: SightList(),
//      home: SightDetail(mocks[0]),
//      home: Favorites(),
      home: MainScreenWithBottomBar(),
    );
  }
}
