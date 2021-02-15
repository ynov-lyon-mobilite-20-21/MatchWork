import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

// ignore: non_constant_identifier_names
final ThemeData DarkThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.SecondColor,
    appBarTheme: AppBarTheme(color: AppColors.AppBarColor),
    iconTheme: IconThemeData(color: Colors.white, size: 20.0),
    canvasColor: AppColors.AppBarColor,
    focusColor: AppColors.AppBarColor,
    textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontWeight: FontWeight.w600,
        ),
        headline3: TextStyle(
          color: AppColors.AccentColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(color: Colors.white, fontSize: 12.0),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
        subtitle1: TextStyle(
          color: Colors.white70,
          fontSize: 15.0,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
        caption: TextStyle(color: Colors.white, fontSize: 12.0)),
    cardTheme: CardTheme(
      color: AppColors.BackgroundDarkColor,
    ),
    primarySwatch: Colors.grey,
    primaryColor: AppColors.PrimaryColor,
    indicatorColor: Colors.white,
    primaryColorLight: AppColors.AppBarColor,
    primaryColorDark: AppColors.AccentColor,
    brightness: Brightness.dark,
    backgroundColor: AppColors.PrimaryColor,
    accentColor: AppColors.AccentColor,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    cardColor: AppColors.AppBarColor,
    buttonColor: AppColors.PrimaryColor,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.AppBarColor),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))));
