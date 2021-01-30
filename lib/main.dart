import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/provider_setup.dart';
import 'package:match_work/ui/app_router.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/splashscreen.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'ui/views/home_view.dart';
import 'ui/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.StatusBarColor, // status bar color
  ));
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Image _splashscreenBackgroundImage;

  @override
  void initState() {
    super.initState();
    _splashscreenBackgroundImage = Image.asset(AppImages.BackgroundSplashScreen);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_splashscreenBackgroundImage.image, context);
  }

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
    return BaseWidget<ThemeProvider>(
      model: ThemeProvider(),
      builder: (context, model, widget) => MultiProvider(
          providers: providers,
          child: GestureDetector(
            onTap: () => KeyboardUtils.closeKeyboard(context: context),
            child: MaterialApp(
              theme: model.getTheme(),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              onGenerateRoute: AppRouter.generateRoute,
            ),
          )),
    );
  }
}
