import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final TextStyle textStyle;

  BadgeWidget(
      {Key key,
      @required this.text,
      @required this.color,
      @required this.width,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(width)),
      child: Text(
        text,
        style: textStyle ?? TextStyle(color: Colors.white),
      ),
    );
  }
}
