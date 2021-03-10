import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/app_drawer_widget.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/viewmodels/views/bottom_navigation_bar_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isDarkMode = false;

  setUi(){

    DeviceBarUtils.showStatusBar(true);
  }

  @override
  void initState() {
    super.initState();
    setUi();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarViewModel>(
      create: (context) => BottomNavigationBarViewModel(),
      child: Consumer2<BottomNavigationBarViewModel, ThemeProvider>(
        builder: (context, model, theme, child) => Scaffold(
          backgroundColor: theme.getTheme().backgroundColor,

          body: model.currentScreen,
          drawer: AppDrawerWidget(theme: theme),
          drawerEdgeDragWidth: 0,
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
            backgroundColor:
                theme.getTheme().bottomNavigationBarTheme.backgroundColor,
            currentIndex: model.currentTab,
            selectedItemColor: theme.getTheme().accentColor,
            unselectedItemColor: theme.getTheme().textTheme.bodyText1.color,
            onTap: (int index) {
              model.currentTab = index;
            },
          ),
        ),
      ),
    );
  }
}
