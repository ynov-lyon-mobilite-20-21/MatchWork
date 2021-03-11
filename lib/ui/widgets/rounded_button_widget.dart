import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String text;
  final Color textColor;
  final Border border;
  final double height;
  final double width;

  RoundedButton(
      {Key key,
      @required this.onTap,
      @required this.color,
      @required this.text,
      @required this.textColor,
      this.border,
      this.height = 40.0,
      this.width = 250.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;

    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: _padding),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5.0),
              border: border),
          child: Text(
            text,
            textScaleFactor: 1.5,
            style: TextStyle(
              color: textColor,
            ),
          )),
    );
  }
}
