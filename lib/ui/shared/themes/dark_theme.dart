import 'package:flutter/material.dart';
import 'package:match_work/ui/shared/app_colors.dart';

// ignore: non_constant_identifier_names
final ThemeData DarkThemeData = ThemeData(
    scaffoldBackgroundColor: SECOND_COLOR,
    appBarTheme: AppBarTheme(
      color: PRIMARY_COLOR,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          color: Colors.white70,
          fontSize: 18.0,
        ),
        caption: TextStyle(color: Colors.white, fontSize: 12.0)),
    cardTheme: CardTheme(
      color: Colors.green,
    ),
    primarySwatch: Colors.grey,
    primaryColor: PRIMARY_COLOR,
    indicatorColor: Colors.white,
    focusColor: PRIMARY_COLOR,
    primaryColorLight: SECOND_COLOR,
    primaryColorDark: PRIMARY_COLOR,
    brightness: Brightness.dark,
    backgroundColor: SECOND_COLOR,
    accentColor: ACCENT_COLOR,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: PRIMARY_COLOR));
