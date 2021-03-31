import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

class AppBarWidget {
  static Widget showAppBar(
      {@required BuildContext context,
      @required bool isVisible,
      Color color = Colors.white,
      Color iconColor = AppColors.PrimaryColor,
      Color textColor = Colors.white}) {
    assert(context != null);
    assert(isVisible != null);

    return isVisible
        ? AppBar(
            title: Container(padding: EdgeInsets.only(left: 110),
              child: Text('Profil',
              style: TextStyle(color: iconColor),)
            ),
            elevation: 0,
            backgroundColor: color,
            leading: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
              child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        size:
                            Theme.of(context).iconTheme.copyWith(size: 35).size,
                        color: Theme.of(context)
                            .iconTheme
                            .copyWith(color: iconColor)
                            .color,
                      ),
                    ],
                  )),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: AppBar(
              backgroundColor: color,
              elevation: 0,
              leading: Container(),
            ),
          );
  }
}
