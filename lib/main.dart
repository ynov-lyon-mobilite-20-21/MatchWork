import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/provider_setup.dart';
import 'package:match_work/ui/provider/navigation_provider.dart';
import 'package:match_work/ui/views/conversation_view.dart';
import 'package:match_work/ui/views/pushed_screen.dart';
import 'package:match_work/ui/views/root.dart';
import 'package:provider/provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
                initialRoute: ConversationView.route,
                //home: SplashScreen(),
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case PushedScreen.route:
                      return MaterialPageRoute(builder: (_) => PushedScreen());
                      break;
                    case Root.route:
                      return MaterialPageRoute(builder: (_) => Root());
                      break;
                    case ConversationView.route:
                      User caller = User(
                          uid: 'HgjjWAvUdbUpZH70JiX2ZLWA2W22',
                          lastName: 'Nom',
                          firstName: 'Prenom',
                          mail: 'florianspadaro@gmail.com');
                      //User caller = settings.arguments as User;
                      return MaterialPageRoute(
                          builder: (_) => ConversationView(
                                caller: caller,
                              ));
                      break;
                    default:
                      return MaterialPageRoute(
                          builder: (_) => DefaultView(
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
