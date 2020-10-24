import 'package:flutter/material.dart';

class Screen {

  final String title;

  final Widget child;

  final RouteFactory onGenerateRoute;

  final String initialRoute;

  final GlobalKey<NavigatorState> navigatorState;

  final String activeIconEndpoint;

  final String inactiveIconEndpoint;

  final ScrollController scrollController;

  Screen({
    @required this.title,
    @required this.child,
    @required this.onGenerateRoute,
    @required this.initialRoute,
    @required this.navigatorState,
    this.activeIconEndpoint,
    this.inactiveIconEndpoint,
    this.scrollController,
  });
}