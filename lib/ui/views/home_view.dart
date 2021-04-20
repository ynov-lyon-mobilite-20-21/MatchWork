import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/string.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/app_drawer_widget.dart';
import 'package:match_work/ui/widgets/badge_widget.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/viewmodels/views/bottom_navigation_bar_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isDarkMode = false;
  double iconHeight = 30;

  setUi() {
    DeviceBarUtils.showStatusBar(true);
    DeviceBarUtils.changeStatusBarColor(AppColors.StatusBarColor);
  }

  @override
  void initState() {
    super.initState();
    setUi();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return BaseWidget<BottomNavigationBarViewModel>(
        onModelReady: (model) {
          model.listenNbUnreadConversationsStream();
          model.listenNbMatchRequestsStream();
        },
        model: BottomNavigationBarViewModel(
            authenticationService: Provider.of(context)),
        builder: (context, model, widget) => Scaffold(
              backgroundColor: theme.getTheme().backgroundColor,
              body: model.currentScreen,
              drawer: AppDrawerWidget(theme: theme),
              drawerEdgeDragWidth: 0,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Image(
                        image: AssetImage(isDarkMode
                            ? AppIcons.InactiveProfileDark
                            : AppIcons.InactiveProfile),
                        height: iconHeight,
                      ),
                      activeIcon: Image(
                        image: AssetImage(AppIcons.ActiveProfile),
                        height: iconHeight,
                      ),
                      label: ProfiNavbarTitlel),
                  BottomNavigationBarItem(
                      icon: Image(
                        image: AssetImage(isDarkMode
                            ? AppIcons.InactiveSwipeDark
                            : AppIcons.InactiveSwipe),
                        height: iconHeight,
                      ),
                      activeIcon: Image(
                        image: AssetImage(AppIcons.ActiveSwipe),
                        height: iconHeight,
                      ),
                      label: SwipeNavBarTitle),
                  BottomNavigationBarItem(
                      icon: Image(
                        image: AssetImage(isDarkMode
                            ? AppIcons.InactiveNewsDark
                            : AppIcons.InactiveNews),
                        height: iconHeight,
                      ),
                      activeIcon: Image(
                        image: AssetImage(AppIcons.ActiveNews),
                        height: iconHeight,
                      ),
                      label: NewsNavBarTitle),
                  BottomNavigationBarItem(
                      icon: showBadges(
                          child: Image(
                            image: AssetImage(isDarkMode
                                ? AppIcons.InactiveChatDark
                                : AppIcons.InactiveChat),
                            height: iconHeight,
                          ),
                          nbConversationsStream: model.outNbUnreadConversations,
                          nbMatchRequestsStream: model.outNbMatchRequests),
                      activeIcon: showBadges(
                          child: Image(
                            image: AssetImage(AppIcons.ActiveChat),
                            height: iconHeight,
                          ),
                          nbMatchRequestsStream: model.outNbMatchRequests,
                          nbConversationsStream:
                              model.outNbUnreadConversations),
                      label: ChatNavBarTitle),
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
            ));
  }
}

Widget showBadges(
        {@required Widget child,
        @required Stream nbMatchRequestsStream,
        @required Stream nbConversationsStream}) =>
    Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<int>(
                stream: nbMatchRequestsStream,
                builder: (context, snapshot) =>
                    snapshot.hasData && snapshot.data > 0
                        ? BadgeWidget(
                            width: 15.0,
                            color: Colors.blue,
                            text: "${snapshot.data}",
                          )
                        : Container()),
            StreamBuilder<int>(
                stream: nbConversationsStream,
                builder: (context, snapshot) =>
                    snapshot.hasData && snapshot.data > 0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: BadgeWidget(
                              width: 15.0,
                              color: Colors.red,
                              text: "${snapshot.data}",
                            ),
                          )
                        : Container()),
          ],
        ),
      ],
    );
