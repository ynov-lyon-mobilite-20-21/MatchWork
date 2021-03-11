import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget {
  static Widget showAppBar(
      BuildContext context, String title, Color iconColor, Color textColor) {
    assert(context != null);
    assert(title != null);
    assert(iconColor != null);
    assert(textColor != null);

    return Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height / 50,
            top: MediaQuery.of(context).size.height / 50),
        child: InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  size: Theme.of(context).iconTheme.copyWith(size: 35).size,
                  color: Theme.of(context)
                      .iconTheme
                      .copyWith(color: iconColor)
                      .color,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 7),
                    child: Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textColor, fontSize: 22)))
              ],
            )));
  }
}
