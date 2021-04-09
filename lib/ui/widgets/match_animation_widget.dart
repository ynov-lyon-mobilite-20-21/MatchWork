import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MatchAnimationWidget extends StatefulWidget {
  @override
  _MatchAnimationWidgetState createState() => _MatchAnimationWidgetState();
}

class _MatchAnimationWidgetState extends State<MatchAnimationWidget> {
  bool _animationIsPlaying = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) {
      setState(() {
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
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Visibility(
      visible: _animationIsPlaying,
      child: Center(
        child: Container(
            color: Colors.transparent.withOpacity(0.6),
            child: Center(
              child: Image.asset(
                isDarkMode ? AppAnimations.MatchDark : AppAnimations.MatchLight,
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}
