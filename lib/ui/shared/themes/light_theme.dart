import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

// ignore: non_constant_identifier_names
final ThemeData LightThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.BackgroundLightColor,
    appBarTheme: AppBarTheme(color: AppColors.AppBarColor),
    textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.AppBarColor,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: AppColors.PrimaryColor,
          fontSize: 25.0,
        ),
        bodyText1: TextStyle(
          color: AppColors.PrimaryColor,
        ),
        subtitle1: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        caption: TextStyle(color: Colors.grey[400], fontSize: 12.0)),
    cardTheme: CardTheme(
      color: AppColors.AppBarColor,
    ),
    primarySwatch: Colors.grey,
    primaryColor: AppColors.PrimaryColor,
    indicatorColor: AppColors.AppBarColor,
    focusColor: Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.white,
    brightness: Brightness.light,
    backgroundColor: AppColors.BackgroundLightColor,
    accentColor: AppColors.AccentColor,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white));
