import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/search_radius.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/main_screen_with_bottom_bar.dart';

var searchRadius = SearchRadius(distanceValueFrom, distanceValueUp);
var selectedCategories = List<Category>.from(categories);

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
      home: MainScreenWithBottomBar(),
    );
  }
}
