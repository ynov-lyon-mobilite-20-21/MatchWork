import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

// ignore: non_constant_identifier_names
final ThemeData DarkThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.PrimaryColor,
    appBarTheme: AppBarTheme(color: AppColors.AppBarColor),
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
      color: AppColors.AppBarColor,
    ),
    primarySwatch: Colors.grey,
    primaryColor: AppColors.PrimaryColor,
    indicatorColor: Colors.white,
    focusColor: AppColors.AppBarColor,
    primaryColorLight: AppColors.PrimaryColor,
    primaryColorDark: AppColors.AppBarColor,
    brightness: Brightness.dark,
    backgroundColor: AppColors.PrimaryColor,
    accentColor: AppColors.AccentColor,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.AppBarColor));
