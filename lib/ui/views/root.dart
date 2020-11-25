import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/ui/provider/navigation_provider.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  static const route = '/';

  @override
  _Root createState() => _Root();
}

class _Root extends State<Root> {
  bool isDarkModeOn = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Consumer2<NavigationProvider, ThemeProvider>(
      builder: (context, navigationProvider, themeProvider, child) {
        final theme = themeProvider.getTheme();
        final bottomNavigationBarItems = navigationProvider.screens
            .map((screen) => BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(screen.inactiveIconEndpoint),
                  height: 30,
                ),
                activeIcon: Image(
                  image: AssetImage(screen.activeIconEndpoint),
                  height: 30,
                ),
                title: Text(screen.title, style: theme.textTheme.subtitle1)))
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = navigationProvider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
            onWillPop: () async => navigationProvider.onWillPop(context),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme(),
              home: Scaffold(
                appBar: AppBar(
                  title: Image.asset("assets/images/splash.png",
                      fit: BoxFit.contain, height: 50),
                  backgroundColor: theme.appBarTheme.color,
                  actions: <Widget>[
                    Switch(
                      value: isDarkModeOn,
                      onChanged: (value) {
                        setState(() {
                          isDarkModeOn = value;
                          themeProvider.changeTheme(isDarkModeOn);
                        });
                      },
                    )
                  ],
                ),
                body: IndexedStack(
                  children: screens,
                  index: navigationProvider.currentTabIndex,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: bottomNavigationBarItems,
                  currentIndex: navigationProvider.currentTabIndex,
                  onTap: navigationProvider.setTab,
                  backgroundColor: theme.scaffoldBackgroundColor,
                ),
              ),
            ));
      },
    );
  }
}
