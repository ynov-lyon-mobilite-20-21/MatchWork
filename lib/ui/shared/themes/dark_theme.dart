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
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
        subtitle1: TextStyle(
          color: Colors.white70,
          fontSize: 18.0,
        ),
        caption: TextStyle(color: Colors.white, fontSize: 12.0)),
    cardTheme: CardTheme(
      color: AppColors.BackgroundDarkColor,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    primarySwatch: Colors.grey,
    primaryColor: AppColors.PrimaryColor,
    indicatorColor: Colors.white,
    focusColor: AppColors.AppBarColor,
    primaryColorLight: AppColors.PrimaryColor,
    primaryColorDark: AppColors.AppBarColor,
    brightness: Brightness.dark,
    backgroundColor: AppColors.PrimaryColor,
    accentColor: AppColors.AccentColor,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.black12,
    cardColor: Colors.white,
    buttonColor: AppColors.PrimaryColor,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.AppBarColor)
);
