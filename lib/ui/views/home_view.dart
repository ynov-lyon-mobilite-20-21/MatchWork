import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/viewmodels/views/bottom_navigation_bar_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _HomeViewState extends State<HomeView> {
  var isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarViewModel>(
      create: (context) => BottomNavigationBarViewModel(),
      child: Consumer2<BottomNavigationBarViewModel, ThemeProvider>(
        builder: (context, model, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: Scaffold(
            backgroundColor: theme.getTheme().backgroundColor,
            appBar: AppBar(
                title: Center(
                  child: Image.asset(AppImages.LogoMatchWork,
                      fit: BoxFit.contain, height: 50),
                ),
                actionsIconTheme: theme.getTheme().iconTheme,
                backgroundColor: theme.getTheme().appBarTheme.color),
            body: model.currentScreen,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage(AppIcons.InactiveProfile),
                      height: 30,
                    ),
                    activeIcon: Image(
                      image: AssetImage(AppIcons.ActiveProfile),
                      height: 30,
                    ),
                    label: "Profile"),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage(AppIcons.InactiveSwipe),
                      height: 30,
                    ),
                    activeIcon: Image(
                      image: AssetImage(AppIcons.ActiveSwipe),
                      height: 30,
                    ),
                    label: "Swipe"),
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage(AppIcons.InactiveChat),
                      height: 30,
                    ),
                    activeIcon: Image(
                      image: AssetImage(AppIcons.ActiveChat),
                      height: 30,
                    ),
                    label: "Tchat"),
              ],
              backgroundColor: theme.getTheme().bottomAppBarColor,
              currentIndex: model.currentTab,
              onTap: (int index) {
                model.currentTab = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}