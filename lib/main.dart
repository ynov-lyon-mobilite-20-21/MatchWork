import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:match_work/provider/navigation_provider.dart';
import 'package:match_work/view/splashscreen.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ],
  child: App(),
));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Consumer<ThemeProvider>(
        builder: (context, theme, _) =>  MaterialApp(
      onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));
  }
}