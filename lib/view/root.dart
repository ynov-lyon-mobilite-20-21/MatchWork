import 'package:flutter/material.dart';
import 'package:match_work/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:match_work/provider/navigation_provider.dart';

class Root extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bottomNavigationBarItems = provider.screens
            .map((screen) => BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(screen.inactiveIconEndpoint),
                  height: 30,
                ),
                activeIcon: Image(
                  image: AssetImage(screen.activeIconEndpoint),
                  height: 30,
                ),
                label: screen.title))
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            appBar: AppBar(
              title: Image.asset("lib/images/splash.png", fit: BoxFit.contain, height: 50),

              backgroundColor: PRIMARY_COLOR
            ),
            body: IndexedStack(
              children: screens,
              index: provider.currentTabIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavigationBarItems,
              currentIndex: provider.currentTabIndex,
              onTap: provider.setTab,
            ),
          ),
        );
      },
    );
  }
}
