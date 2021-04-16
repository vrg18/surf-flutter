import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

import 'main_screen_with_bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future _isInitialized;
  late Future _isTimePasted;

  @override
  void initState() {
    super.initState();
    _isInitialized = _navigateToNext();
    _isTimePasted = Future.delayed(timeToShowSplash);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _isTimePasted,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return FutureBuilder<void>(
                future: _isInitialized,
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Initialization error!');
                  if (snapshot.connectionState == ConnectionState.done) _gotoNextScreen();
                  return CircularProgressIndicator();
                },
              );
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  /// Асинхронно инициализируем приложение начальными данными
  Future _navigateToNext() async {
    return await context.read<SightProvider>().initializeApp();
  }

  /// Переход на следующий экран
  _gotoNextScreen() {
    SchedulerBinding.instance!.addPostFrameCallback((_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  context.read<Web>().isWeb ? WebWrapper(MainScreenWithBottomBar()) : MainScreenWithBottomBar()),
        ));
  }
}
