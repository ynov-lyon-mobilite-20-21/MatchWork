import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/login_view_model.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/round_logo_button.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import 'base_widget.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppBackgroundImages.BackgroundHomeDark),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BaseWidget<LoginViewModel>(
            model: LoginViewModel(
                authenticationService:
                    Provider.of<AuthenticationService>(context)),
            builder: (_, model, __) => Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        AppLogoImages.LogoMatchWorkTextTuba,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Column(
                        children: [
                          RoundedButton(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(RoutePath.Register),
                              color: AppColors.CircleAvatarBorderColor,
                              text: "Inscription",
                              textColor: Colors.white),
                          SizedBox(
                            height: 15.0,
                          ),
                          RoundedButton(
                            onTap: () => Navigator.of(context)
                                .pushNamed(RoutePath.Login),
                            color: Colors.transparent,
                            text: "Connexion",
                            textColor: Colors.white,
                            border: Border.all(color: Colors.white),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundLogoButton(
                                  color: Colors.white,
                                  logo: AppLogoImages.LogoGoogle,
                                  size: 50.0,
                                  onTap: () => model.loginWithGoogle().then(
                                      (bool success) =>
                                          loginWithExternalService(
                                              context: context,
                                              scaffoldKey: _scaffoldKey,
                                              success: success,
                                              error: model.error))),
                              Visibility(
                                visible: Platform.isIOS,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: RoundLogoButton(
                                      color: Colors.white,
                                      logo: AppLogoImages.LogoApple,
                                      size: 50.0,
                                      onTap: () => model.loginWithApple().then(
                                          (bool success) =>
                                              loginWithExternalService(
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  success: success,
                                                  error: model.error))),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void loginWithExternalService(
    {@required BuildContext context,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required bool success,
    String error}) {
  if (success) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RoutePath.Home, (route) => false);
  } else {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(error),
    ));
  }
}
