import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/shared/app_colors.dart';

// ignore: non_constant_identifier_names
final ThemeData DarkThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.black12,
  appBarTheme: AppBarTheme(
    color: AppColors.AppBarColor,
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
    subtitle1: TextStyle(
      color: Colors.white70,
      fontSize: 18.0,
    ),
  ),
  cardTheme: CardTheme(
    color: const Color(0xff006E7F),
  ),
  primarySwatch: Colors.grey,
  primaryColor: AppColors.PrimaryColor,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF006E7F),
  accentColor: AppColors.AccentColor,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);
