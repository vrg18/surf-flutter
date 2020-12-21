import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

const currentThemeIsDark = false; // todo потом уйдет в "Настройки"

final lightTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: lmElementPrimaryColor,
    backgroundColor: lmMainBackgroundColor,
    scaffoldBackgroundColor: lmMainBackgroundColor,
    textTheme: TextTheme(bodyText2: lmMainColorTextStyle),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: lmElementPrimaryColor,
    ));

final darkTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: dmElementPrimaryColor,
    backgroundColor: dmMainBackgroundColor,
    scaffoldBackgroundColor: dmMainBackgroundColor,
    textTheme: TextTheme(bodyText2: dmMainColorTextStyle),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: dmMainBackgroundColor,
      unselectedItemColor: dmElementPrimaryColor,
    ));
