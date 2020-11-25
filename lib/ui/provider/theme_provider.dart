import 'package:flutter/material.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/ui/shared/themes/dark_theme.dart';
import 'package:match_work/ui/shared/themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  final darkTheme = DarkThemeData;
  final lightTheme = LightThemeData;

  ThemeData _themeData;
  bool isDarkMode;
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void changeTheme(bool isDarkModeOn) async {
    String themePreference;
    if (isDarkModeOn) {
      _themeData = darkTheme;
      isDarkMode = true;
      themePreference = "dark";
    } else {
      _themeData = lightTheme;
      isDarkMode = false;
      themePreference = "light";
    }

    StorageManager.saveData('themeMode', themePreference);
    notifyListeners();
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
