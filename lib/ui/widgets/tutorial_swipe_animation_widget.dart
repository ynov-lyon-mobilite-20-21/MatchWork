import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialSwipeAnimationWidget extends StatefulWidget {
  @override
  _TutorialSwipeAnimationWidgetState createState() =>
      _TutorialSwipeAnimationWidgetState();
}

class _TutorialSwipeAnimationWidgetState
    extends State<TutorialSwipeAnimationWidget> {
  bool _animationIsPlaying = true;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunchSwipe', false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7)).then((value) {
      setState(() {
        addStringToSF();
        _animationIsPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _animationIsPlaying,
      child: Center(
        child: Container(
            color: Colors.transparent.withOpacity(0.6),
            child: Center(
              child: Image.asset(
                AppAnimations.FirstSwipe,
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}
