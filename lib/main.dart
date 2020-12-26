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
import 'package:provider/provider.dart';

import 'domain/current_theme.dart';

var searchRadius = SearchRadius(distanceValueFrom, distanceValueUp);
var selectedCategories = List<Category>.from(categories);

main() => runApp(
      DevicePreview(
        enabled: isWeb(),
        devices: [Devices.android.samsungS20, Devices.android.samsungNote10Plus],
        defaultDevice: Devices.android.samsungNote10Plus,
        isToolbarVisible: true,
        builder: (context) => ChangeNotifierProvider<CurrentTheme>(
          create: (context) => CurrentTheme(),
          child: MyApp(),
        ),
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
    return Consumer<CurrentTheme>(
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: appTitle,
        theme: theme.isDark ? darkTheme : lightTheme,
        home: MainScreenWithBottomBar(),
      ),
    );
  }
}
