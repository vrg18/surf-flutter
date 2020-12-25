import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

/// Определения светлой и темной тем

final lightTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: lightElementPrimaryColor,
    backgroundColor: lightMainBackgroundColor,
    scaffoldBackgroundColor: lightMainBackgroundColor,
    textTheme: TextTheme(bodyText2: lightMainColorTextStyle),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: lightElementPrimaryColor,
    ));

final darkTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: darkElementPrimaryColor,
    backgroundColor: darkMainBackgroundColor,
    scaffoldBackgroundColor: darkMainBackgroundColor,
    textTheme: TextTheme(bodyText2: darkMainColorTextStyle),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkMainBackgroundColor,
      unselectedItemColor: darkElementPrimaryColor,
    ));
