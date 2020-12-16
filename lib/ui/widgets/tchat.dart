import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Tchat extends StatelessWidget {
  static const route = '/tchat';

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child: Text(
            "Tchat",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          color: theme.cardTheme.color,
        ),
      ),
    );
  }
}