import 'package:flutter/cupertino.dart';

class DrawerOptions {
  String title;
  String iconPath;
  double iconSize;

  DrawerOptions({
    @required this.iconPath,
    @required this.title,
    this.iconSize = 30,
  });
}