import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/shared/app_colors.dart';

final ThemeData LightThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xffFFFFFF),
  appBarTheme: AppBarTheme(
    color: AppColors.AppBarColor,
    iconTheme: IconThemeData(
      color: const Color(0xFF006E7F ),
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
    color: const Color(0xff006E7F),
  ),
  primarySwatch: Colors.grey,
  primaryColor: AppColors.PrimaryColor,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: AppColors.AccentColor,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
