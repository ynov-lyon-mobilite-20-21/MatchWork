import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/app_file.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/ui/views/conversation_view.dart';
import 'package:match_work/ui/views/home_view.dart';
import 'package:match_work/ui/views/login_view.dart';
import 'package:match_work/ui/views/modification_profil.dart';
import 'package:match_work/ui/views/pdf_screen_view.dart';
import 'package:match_work/ui/views/remove_auth_user_view.dart';
import 'package:match_work/ui/views/sign_in_view.dart';
import 'package:match_work/ui/views/sign_up_view.dart';
import 'package:match_work/ui/views/tutorial_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePath.Login:
        return MaterialPageRoute(builder: (_) => SignInView());
      case RoutePath.Start:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePath.Register:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case RoutePath.Tutorial:
        return MaterialPageRoute(builder: (_) => TutorialView());
      case RoutePath.EditProfile:
        return MaterialPageRoute(builder: (_) => ModificationProfile());
      case RoutePath.Conversation:
        User caller = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => ConversationView(
                  caller: caller,
                ));
      case RoutePath.Pdf:
        AppFile file = settings.arguments as AppFile;
        return MaterialPageRoute(builder: (_) => PDFScreenView(pdf: file));
      case RoutePath.DeleteUser:
        return MaterialPageRoute(builder: (_) => RemoveAuthUserView());
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(
                  routePath: settings.name,
                ));
    }
  }
}

class ErrorView extends StatelessWidget {
  final String routePath;

  ErrorView({Key key, @required this.routePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ERREUR"),
      ),
      body: Center(
        child: Text("La route $routePath est introuvable"),
      ),
    );
  }
}
