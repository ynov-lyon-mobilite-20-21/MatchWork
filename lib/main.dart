import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/provider_setup.dart';
import 'package:match_work/ui/views/home_view.dart';
import 'package:match_work/ui/views/login_view.dart';
import 'package:match_work/ui/views/splashscreen.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'ui/provider/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
              providers: providers,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeView(),
                onGenerateRoute: (RouteSettings settings) {
                  print('Generating route: ${settings.name}');
                  switch (settings.name) {
                    case RoutePath.Home:
                      return MaterialPageRoute(builder: (_) => HomeView());
                    case RoutePath.Login:
                      return MaterialPageRoute(builder: (_) => LoginView());
                    case RoutePath.Register:
                      return MaterialPageRoute(builder: (_) => HomeView());
                    default:
                      return MaterialPageRoute(
                          builder: (_) => ErrorView(
                                routePath: settings.name,
                              ));
                  }
                },
              ));
        }
        return Container();
      },
    );
  }
}

class ErrorView extends StatelessWidget {
  final String routePath;

  ErrorView({Key key, @required this.routePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ERREUR")),
      body: Center(
        child: Text("La route $routePath est introuvable"),
      ),
    );
  }
}