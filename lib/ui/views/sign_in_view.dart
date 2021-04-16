import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/core/viewmodels/views/sign_in_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/loader_widget.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<SignInViewModel>(
      model: SignInViewModel(
          authenticationService: Provider.of<AuthenticationService>(context)),
      builder: (_, model, __) => Theme(
        data: theme,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            iconTheme: IconThemeData(color: theme.textTheme.headline2.color),
            backgroundColor: theme.backgroundColor,
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? AppBackgroundImages.BackgroundLoginDark
                            : AppBackgroundImages.BackgroundLoginLight),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: KeyboardUtils.isHidden(context),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.2),
                          child: Image.asset(
                            Provider.of<ThemeProvider>(context).isDarkMode
                                ? AppImages.WelcomeWhite
                                : AppImages.WelcomeBlue,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Form(
                              key: model.formKey,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: model.error != null,
                                    child: Center(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          model.error ?? '',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    )),
                                  ),
                                  TextFieldWidget(
                                    controller: model.emailController,
                                    label: 'Identifiant',
                                    inputType: TextInputType.emailAddress,
                                    validation: (value) =>
                                        model.emailValidator(value),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFieldWidget(
                                    controller: model.passwordController,
                                    isObscureText: true,
                                    label: 'Mot de passe',
                                    validation: (value) =>
                                        model.passwordValidator(value),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  RoundedButton(
                                    onTap: () {
                                      if (model.formKey.currentState
                                          .validate()) {
                                        model.signIn().then((bool success) {
                                          if (success) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomeView()));
                                          }
                                        });
                                      }
                                    },
                                    color: AppColors.CircleAvatarBorderColor,
                                    text: "Connexion",
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: KeyboardUtils.isHidden(context),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Pas encore de compte?",
                                  style: theme.textTheme.subtitle1,
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed(RoutePath.Register),
                                  child: Text(
                                    "Inscrivez-vous",
                                    style: TextStyle(color: theme.accentColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              model.busy ? LoaderWidget() : Container()
            ],
          ),
        ),
      ),
    );
  }
}
