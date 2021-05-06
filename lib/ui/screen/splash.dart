import 'package:flutter/material.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/ui/screen/on_boarding.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _isInitialized;
  late bool _isTimeExpired;

  @override
  void initState() {
    super.initState();
    _isInitialized = false;
    _isTimeExpired = false;
    context.read<SightProvider>().initializeApp().then((_) => _initializeComplete());
    Future.delayed(timeToShowSplash).then((_) => _delayTimeExpired());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Инициализация приложения закончилась
  void _initializeComplete() {
    if (_isTimeExpired) {
      _gotoNextScreen();
    } else {
      _isInitialized = true;
    }
  }

  /// Минимальное время заставки истекло
  void _delayTimeExpired() {
    if (_isInitialized) {
      _gotoNextScreen();
    } else {
      _isTimeExpired = true;
    }
  }

  /// Переход на следующий экран
  void _gotoNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => context.read<Web>().isWeb ? WebWrapper(OnBoarding()) : OnBoarding()),
    );
  }
}
