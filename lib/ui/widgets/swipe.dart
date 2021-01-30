import 'package:flutter/material.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Swipe extends StatefulWidget{
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
bool isDarkMode = false;

@override
Widget build(BuildContext context) {
  var theme = Provider.of<ThemeProvider>(context);
  return Scaffold(
    body: Column(
      children: [
        CheckboxListTile(
          title: Text("Activer dark mode"),
          value: theme.isDarkMode,
          onChanged: (newValue) {
            setState(()  {
              theme.isDarkMode = newValue;
              if(theme.isDarkMode) {
                theme.setDarkMode();
              } else {
                theme.setLightMode();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 300,
            child: Text(
              "Swipe",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            color: theme.getTheme().cardTheme.color,
          ),
        ),
      ],
    ),
  );
}
}
