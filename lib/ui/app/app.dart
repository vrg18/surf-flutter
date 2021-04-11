import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/main_screen_with_bottom_bar.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

/// Начало приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<CurrentTheme>(create: (_) => CurrentTheme()),
          ChangeNotifierProvider<SightProvider>(create: (_) => SightProvider()),
          Provider<Web>(create: (_) => Web()),
        ],
        child: Consumer<CurrentTheme>(
          builder: (context, theme, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale('ru', 'RU'),
              title: appTitle,
              theme: theme.isDark ? darkTheme : lightTheme,
              home: Builder(
                builder: (BuildContext context) =>
                    context.read<Web>().isWeb ? WebWrapper(MainScreenWithBottomBar()) : MainScreenWithBottomBar(),
              )),
        ),
      );
}
