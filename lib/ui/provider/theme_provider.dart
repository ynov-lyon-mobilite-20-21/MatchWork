import 'package:flutter/material.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:match_work/ui/shared/themes/dark_theme.dart';
import 'package:match_work/ui/shared/themes/light_theme.dart';

class ThemeProvider extends BaseModel  {
  final darkTheme = DarkThemeData;
  final lightTheme = LightThemeData;

  ThemeData _themeData = LightThemeData;
  bool isDarkMode = false;
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        isDarkMode = false;
        _themeData = lightTheme;
      } else {
        isDarkMode = true;
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}