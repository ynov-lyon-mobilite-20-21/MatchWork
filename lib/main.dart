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

class MyApp extends StatelessWidget {
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
