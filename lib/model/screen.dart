import 'package:flutter/material.dart';

class Screen {

  /// [title] of the screen
  final String title;

  /// the view associated to the screen
  final Widget child;

  /// [onGenerateRoute]  automatically generates routes in order to navigate in the application
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