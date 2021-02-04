import 'package:flutter/material.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:match_work/ui/shared/themes/dark_theme.dart';
import 'package:match_work/ui/shared/themes/light_theme.dart';

class ThemeProvider extends BaseModel {
  final darkTheme = DarkThemeData;
  final lightTheme = lightThemeData;

  ThemeData _themeData = lightThemeData;
  bool isDarkMode = false;
  ThemeData getTheme() => _themeData;

  set themeData(ThemeData value) {
    if (value == darkTheme) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    _themeData = value;
  }

  ThemeProvider() {
    themeData = lightTheme;
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        themeData = lightTheme;
      } else {
        print('setting dark theme');
        themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void changeTheme(bool isDarkModeOn) async {
    busy = true;

    String themePreference;
    if (isDarkModeOn) {
      themeData = darkTheme;
      themePreference = "dark";
    } else {
      themeData = lightTheme;
      themePreference = "light";
    }

    StorageManager.saveData('themeMode', themePreference);
    busy = false;
  }

  void setDarkMode() async {
    themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
