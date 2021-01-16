import 'package:flutter/material.dart';
import 'package:match_work/ui/shared/app_colors.dart';

// ignore: non_constant_identifier_names
final ThemeData LightThemeData = ThemeData(
    scaffoldBackgroundColor: BACKGROUND_COLOR,
    appBarTheme: AppBarTheme(
      color: PRIMARY_COLOR,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
          color: PRIMARY_COLOR,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          color: PRIMARY_COLOR,
        ),
        subtitle1: TextStyle(
          color: Colors.grey[400],
          fontSize: 18.0,
        ),
        caption: TextStyle(color: Colors.grey[400], fontSize: 12.0)),
    cardTheme: CardTheme(
      color: Colors.greenAccent,
    ),
    primarySwatch: Colors.grey,
    primaryColor: PRIMARY_COLOR,
    indicatorColor: PRIMARY_COLOR,
    focusColor: BACKGROUND_COLOR,
    primaryColorLight: Colors.white,
    primaryColorDark: SECOND_COLOR,
    brightness: Brightness.light,
    backgroundColor: BACKGROUND_COLOR,
    accentColor: ACCENT_COLOR,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white));
