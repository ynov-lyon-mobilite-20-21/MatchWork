import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/core/viewmodels/views/sign_up_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/loaderWidget.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BaseWidget<SignUpViewModel>(
      model: SignUpViewModel(
          authenticationService: Provider.of<AuthenticationService>(context)),
      builder: (_, model, __) => Theme(
        data: theme,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(),
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
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: KeyboardUtils.isHidden(context)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    "Inscription",
                                    style: theme.textTheme.headline2,
                                  ),
                                ),
                                Column(
                                  children: [
                                    _formWidget(
                                        context: context,
                                        model: model,
                                        scaffoldKey: _scaffoldKey),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Déjà un compte?",
                                          style: theme.textTheme.subtitle1,
                                        ),
                                        InkWell(
                                          onTap: () => Navigator.of(context)
                                              .pushReplacementNamed(
                                                  RoutePath.Login),
                                          child: Text(
                                            "Connectez-vous",
                                            style: TextStyle(
                                                color: theme.accentColor),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Column(
                              children: [
                                _formWidget(
                                    context: context,
                                    model: model,
                                    scaffoldKey: _scaffoldKey)
                              ],
                            ),
                          ),
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

Widget _formWidget(
        {@required BuildContext context,
        @required SignUpViewModel model,
        @required GlobalKey<ScaffoldState> scaffoldKey}) =>
    Form(
      key: model.formKey,
      child: Column(
        children: [
          TextFieldWidget(
            controller: model.nameController,
            label: 'Nom',
            validation: (value) => model.nameValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            controller: model.firstNameController,
            label: 'Prénom',
            validation: (value) => model.nameValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            controller: model.emailController,
            label: 'Email',
            inputType: TextInputType.emailAddress,
            validation: (value) => model.emailValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            controller: model.passwordController,
            isObscureText: true,
            label: 'Mot de passe',
            validation: (value) => model.passwordValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            controller: model.confirmationController,
            isObscureText: true,
            label: 'Confirmation du mot de passe',
            validation: (value) => model.confirmationValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Checkbox(
                value: model.isAccepted,
                onChanged: model.acceptTerms,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                      text: "J'accepte les ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: "conditions générales d'utilisation ",
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .getTheme()
                                    .accentColor)),
                        TextSpan(text: "de l'application")
                      ]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          RoundedButton(
            onTap: () {
              if (model.formKey.currentState.validate()) {
                model.signUp().then((bool success) {
                  if (success) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RoutePath.Home, (route) => false);
                  } else {
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(model.error),
                    ));
                  }
                });
              }
            },
            color: AppColors.CircleAvatarBorderColor,
            text: "Enregistrer",
            textColor: Colors.white,
          ),
        ],
      ),
    );
