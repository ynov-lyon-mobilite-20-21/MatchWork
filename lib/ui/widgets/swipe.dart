import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Swipe extends StatelessWidget {
  static const route = '/swipe';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child: Text(
            "Swipe",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
