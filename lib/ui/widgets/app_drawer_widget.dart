import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/constants/string.dart';
import 'package:match_work/core/models/drawer_option.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/login_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

const TUTORIAL = 0;
const SETTINGS = 1;
const EDIT_PROFILE = 2;
const CGU = 3;
const LOGOUT = 4;

class AppDrawerWidget extends StatefulWidget {
  final ThemeProvider theme;

  const AppDrawerWidget({Key key, @required this.theme}) : super(key: key);

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  bool isDarkModeOn;

  @override
  void initState() {
    super.initState();
    isDarkModeOn = widget.theme.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, DrawerOptions> _drawerOption = {
      TUTORIAL: DrawerOptions(
          iconPath: AppIcons.Tutorial, title: TutorialTitle, iconSize: 25),
      SETTINGS:
          DrawerOptions(iconPath: AppIcons.Settings, title: SettingsTitle),
      EDIT_PROFILE: DrawerOptions(
        iconPath: AppIcons.EditProfile,
        title: EditProfileString,
      ),
      CGU: DrawerOptions(iconPath: AppIcons.Settings, title: CguTitle),
      LOGOUT: DrawerOptions(iconPath: AppIcons.Logout, title: LogoutTitle),
    };

    return BaseWidget<LoginViewModel>(
        model: LoginViewModel(
            authenticationService: Provider.of<AuthenticationService>(context)),
        builder: (_, model, __) => Drawer(
              elevation: 10,
              child: Container(
                color: widget.theme.getTheme().cardColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor:
                                  AppColors.CircleAvatarBorderColor,
                              child: CircleAvatar(
                                radius: 47,
                                backgroundImage:
                                    AssetImage(AppImages.UnknownUser),
                              ),
                            ),
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                          Text("Jean-Baptise BENOIT",
                              style:
                                  widget.theme.getTheme().textTheme.bodyText1),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: widget.theme.getTheme().backgroundColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Row(
                                  children: [
                                    Image(
                                        image:
                                            AssetImage(AppIcons.BrightnessMode),
                                        height: 30,
                                        color: widget.theme
                                            .getTheme()
                                            .iconTheme
                                            .color),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 18, right: 30),
                                        child: Text("Mode sombre",
                                            style: widget.theme
                                                .getTheme()
                                                .textTheme
                                                .bodyText1)),
                                    FlutterSwitch(
                                        value: isDarkModeOn,
                                        width: 100,
                                        height: 40,
                                        valueFontSize: 16,
                                        toggleSize: 20.0,
                                        borderRadius: 30.0,
                                        showOnOff: true,
                                        onToggle: (value) {
                                          setState(() {
                                            isDarkModeOn = value;
                                            widget.theme.isDarkMode =
                                                isDarkModeOn;
                                            if (widget.theme.isDarkMode) {
                                              widget.theme.setDarkMode();
                                            } else {
                                              widget.theme.setLightMode();
                                            }
                                          });
                                        }),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                          children: _drawerOption.entries
                              .map((mapEntry) => ListTile(
                                  leading: Image(
                                    image: AssetImage(mapEntry.value.iconPath),
                                    height: mapEntry.value.iconSize,
                                    color:
                                        widget.theme.getTheme().iconTheme.color,
                                  ),
                                  title: Text(
                                    mapEntry.value.title,
                                    style: widget.theme
                                        .getTheme()
                                        .textTheme
                                        .bodyText1,
                                  ),
                                  onTap: () {
                                    switch (mapEntry.key) {
                                      case LOGOUT:
                                        {
                                          model.signOut();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  RoutePath.Start,
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
                                        break;
                                      case TUTORIAL:
                                        {
                                          Navigator.pushNamed(
                                              context, RoutePath.Tutorial);
                                        }
                                        break;
                                      case EDIT_PROFILE:
                                        {
                                          Navigator.pushNamed(
                                              context, RoutePath.EditProfile);
                                        }
                                        break;
                                    }
                                  }))
                              .toList()),
                    ),
                  ],
                ),
              ),
            ));
  }
}
