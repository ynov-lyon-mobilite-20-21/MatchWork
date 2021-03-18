import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create dots that activate when the current page is displayed
class DotIndicatorWidget extends StatelessWidget {
  final dotLenght;
  final activePageIndex;
  final dotActiveColor;
  final dotInactiveColor;
  final height;

  const DotIndicatorWidget(
      {Key key,
      @required this.dotLenght,
      @required this.activePageIndex,
      @required this.dotActiveColor,
      @required this.dotInactiveColor,
      this.height = 20.0})
      : assert(dotLenght != 0),
        assert(activePageIndex != null),
        assert(dotActiveColor != null),
        assert(dotInactiveColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int index = 0; index < dotLenght; index++)
            if (index == activePageIndex) ...[_showIndicator(true)] else
              _showIndicator(false),
        ],
      ),
    );
  }

  Widget _showIndicator(bool isActive) => AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: isActive ? 12 : 8,
        width: isActive ? 12 : 8,
        decoration: BoxDecoration(
            color: isActive ? dotActiveColor : dotInactiveColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      );
}
