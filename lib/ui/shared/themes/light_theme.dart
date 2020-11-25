import 'package:flutter/material.dart';
import 'package:match_work/ui/shared/app_colors.dart';

// ignore: non_constant_identifier_names
final ThemeData LightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: PRIMARY_COLOR,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.greenAccent,
  ),
  primarySwatch: Colors.grey,
  primaryColor: PRIMARY_COLOR,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: ACCENT_COLOR,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
