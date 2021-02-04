import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

final ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: Color(0xffFFFFFF),
    iconTheme: IconThemeData (
        color: AppColors.AccentColor,
        size: 20.0
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.PrimaryColor,
      iconTheme: IconThemeData(
        color: Colors.transparent,
      ),
    ),
    focusColor: Colors.white,
    canvasColor: Colors.white,
    textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: AppColors.PrimaryColor,
          fontSize: 25.0,
        ),
        headline3: TextStyle(
          color: AppColors.AccentColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: AppColors.PrimaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        subtitle2: TextStyle(
          color: Colors.black54,
          fontSize: 12.0,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
        caption: TextStyle(color: AppColors.PrimaryColor, fontSize: 12.0),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        )),
    cardTheme: CardTheme(
      color: AppColors.PrimaryColor,
    ),
    primarySwatch: Colors.grey,
    primaryColorLight: Color(0xffFFFFFF),
    primaryColor: AppColors.PrimaryColor,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: AppColors.AccentColor,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    cardColor: Colors.white,
    indicatorColor: Colors.white,
    buttonColor: AppColors.SecondColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.BackgroundLightColor));
