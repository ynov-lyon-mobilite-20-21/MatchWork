import 'package:flutter/material.dart';

class RoundLogoButton extends StatelessWidget {
  final double size;
  final Color color;
  final String logo;
  final Function onTap;

  RoundLogoButton(
      {Key key,
      @required this.color,
      @required this.logo,
      @required this.size,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3.0),
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(size / 2)),
        child: Image.asset(
          logo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
