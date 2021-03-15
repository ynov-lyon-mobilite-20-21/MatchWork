import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

class LoaderWidget extends StatefulWidget {
  final opacity;

  LoaderWidget({this.opacity = 0.5});

  _LoaderWidget createState() => _LoaderWidget();
}

class _LoaderWidget extends State<LoaderWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, widget.opacity),
      body: Center(
        child: Image.asset(
          AppAnimations.Loader,
          height: MediaQuery.of(context).size.height / 4,
        ),
      ),
    );
  }
}
