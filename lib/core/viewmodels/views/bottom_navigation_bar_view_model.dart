import 'package:flutter/cupertino.dart';

import '../../../ui/widgets/profile.dart';
import '../../../ui/widgets/swipe.dart';
import '../../../ui/widgets/tchat.dart';
import '../base_model.dart';

class BottomNavigationBarViewModel extends BaseModel {
  int _currentTab = 1;

  List<Widget> _screens = [Profile(),Swipe(), Tchat()];
  set currentTab(int tab) {this._currentTab =  tab; notifyListeners();}
  get currentTab => this._currentTab;
  get currentScreen => this._screens[this._currentTab];

}