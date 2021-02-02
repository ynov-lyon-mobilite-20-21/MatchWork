import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class AppDrawerWidget extends StatefulWidget {
  final themeMode;

  const AppDrawerWidget({Key key, @required this.themeMode}) : super(key: key);

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  bool isDarkModeOn;

  @override
  void initState() {
    super.initState();
    isDarkModeOn = widget.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text("Header", style: theme.getTheme().textTheme.bodyText1),
            decoration: BoxDecoration(
              color: theme.getTheme().backgroundColor,
            ),
          ),
          ListTile(
            title: Text("Modification Profile",
                style: theme.getTheme().textTheme.bodyText1),
            onTap: () {
              //Go to the next screen with Navigator.push
            },
          ),
          ListTile(
            title:
                Text("Paramètres", style: theme.getTheme().textTheme.bodyText1),
            onTap: () {
              //Go to the next screen with Navigator.push
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 60),
                            child: Text("Mode sombre", style: theme.getTheme().textTheme.bodyText1)),
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
                                theme.isDarkMode = isDarkModeOn;
                                if (theme.isDarkMode) {
                                  theme.setDarkMode();
                                } else {
                                  theme.setLightMode();
                                }
                              });
                            }),
                      ],
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
