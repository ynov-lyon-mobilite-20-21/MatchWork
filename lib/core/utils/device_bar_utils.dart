import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceBarUtils {
  static changeStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, // status bar color
    ));
  }

  static changeBottomBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: color // navigation bar color
        ));
  }

  static showStatusBar(bool visible) {
    visible
        ? SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)
        : SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
}
