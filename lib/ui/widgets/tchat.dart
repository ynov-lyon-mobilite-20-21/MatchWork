import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tchat extends StatelessWidget {
  static const route = '/tchat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child: Text(
            "Tchat",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}