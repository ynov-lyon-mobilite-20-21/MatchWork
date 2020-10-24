import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:match_work/utils/helpers.dart';
import 'package:match_work/view/profile.dart';
import 'package:match_work/view/pushed_screen.dart';
import 'package:match_work/view/root.dart';
import 'package:match_work/view/swipe.dart';
import 'package:match_work/view/tchat.dart';
import 'package:match_work/model/screen.dart';
import 'package:match_work/widgets/exit_dialog.dart';

const PROFILE_SCREEN = 0;
const SWIPE_SCREEN = 1;
const TCHAT_SCREEN = 2;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = SWIPE_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case PushedScreen.route:
        return MaterialPageRoute(builder: (_) => PushedScreen());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  final Map<int, Screen> _screens = {
    PROFILE_SCREEN: Screen(
      title: 'Profile',
      child: Profile(),
      initialRoute: Profile.route,
      inactiveIconEndpoint: "$ICONS_PATH/profil_off.png",
      activeIconEndpoint: "$ICONS_PATH/profil_on.png",
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case PushedScreen.route:
            return MaterialPageRoute(builder: (_) => PushedScreen());
          default:
            return MaterialPageRoute(builder: (_) => Profile());
        }
      },
      scrollController: ScrollController(),
    ),
    SWIPE_SCREEN: Screen(
      title: 'Swipe',
      child: Swipe(),
      initialRoute: Swipe.route,
      inactiveIconEndpoint: "$ICONS_PATH/match_off.png",
      activeIconEndpoint: "$ICONS_PATH/match_on.png",
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => Swipe());
        }
      },
      scrollController: ScrollController(),
    ),
    TCHAT_SCREEN: Screen(
      title: 'Tchat',
      child: Tchat(),
      inactiveIconEndpoint: "$ICONS_PATH/tchat_off.png",
      activeIconEndpoint: "$ICONS_PATH/tchat_on.png",
      initialRoute: Tchat.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => Tchat());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  void _scrollToStart() {
    if (currentScreen.scrollController != null) {
      currentScreen.scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != PROFILE_SCREEN) {
        setTab(PROFILE_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}