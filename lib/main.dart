import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/provider/navigation_provider.dart';
import 'package:match_work/provider/theme_provider.dart';
import 'package:match_work/services/authentication_service.dart';
import 'package:match_work/view/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(Test());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => NavigationProvider()),
              ChangeNotifierProvider(create: (context) => ThemeProvider()),
              Provider.value(value: AuthenticationService()),
              StreamProvider(
                  create: (context) =>
                      Provider.of<AuthenticationService>(context, listen: false)
                          .user),
            ],
            child: App(),
          );
        }
        return Container();
      },
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp(
              onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ));
  }
}
