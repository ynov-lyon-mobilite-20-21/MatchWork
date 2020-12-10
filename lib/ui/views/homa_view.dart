import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/viewmodels/views/bottom_navigation_bar_view_model.dart';
import '../../utils/helpers.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarViewModel>(
      create: (context) => BottomNavigationBarViewModel(),
      child: Consumer<BottomNavigationBarViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Image.asset("assets/images/splash.png",
                  fit: BoxFit.contain, height: 50),
              backgroundColor: PRIMARY_COLOR),
          body: model.currentScreen,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}profil_off.png"),
                    height: 30,
                  ),
                  activeIcon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}profil_on.png"),
                    height: 30,
                  ),
                  label: "Profile"),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}match_off.png"),
                    height: 30,
                  ),
                  activeIcon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}match_on.png"),
                    height: 30,
                  ),
                  label: "Swipe"),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}tchat_off.png"),
                    height: 30,
                  ),
                  activeIcon: Image(
                    image: AssetImage("${ImagesPath.IconsPath}tchat_on.png"),
                    height: 30,
                  ),
                  label: "Tchat"),
            ],
            backgroundColor: Colors.white,
            currentIndex: model.currentTab,
            onTap: (int index) {
              model.currentTab = index;
              print(model.currentTab);
            },
          ),
        ),
      ),
    );
  }
}
