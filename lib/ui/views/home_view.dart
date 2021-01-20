import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/ui/views/base_widget.dart';

import '../../core/constants/app_constants.dart';
import '../../core/viewmodels/views/bottom_navigation_bar_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BottomNavigationBarViewModel>(
        model: BottomNavigationBarViewModel(),
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                  title: Image.asset(AppImages.LogoMatchWork,
                      fit: BoxFit.contain, height: 50)),
              body: model.currentScreen,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}profil_off.png"),
                        height: 30,
                      ),
                      activeIcon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}profil_on.png"),
                        height: 30,
                      ),
                      label: "Profile"),
                  BottomNavigationBarItem(
                      icon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}match_off.png"),
                        height: 30,
                      ),
                      activeIcon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}match_on.png"),
                        height: 30,
                      ),
                      label: "Swipe"),
                  BottomNavigationBarItem(
                      icon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}tchat_off.png"),
                        height: 30,
                      ),
                      activeIcon: Image(
                        image:
                            AssetImage("${ImagesPath.IconsPath}tchat_on.png"),
                        height: 30,
                      ),
                      label: "Tchat"),
                ],
                currentIndex: model.currentTab,
                onTap: (int index) {
                  model.currentTab = index;
                },
              ),
            ));
  }
}
