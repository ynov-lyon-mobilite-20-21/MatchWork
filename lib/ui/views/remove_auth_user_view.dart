import 'dart:io';

import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/core/viewmodels/views/remove_auth_user_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/round_logo_button.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RemoveAuthUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<RemoveAuthUserViewModel>(
        model: RemoveAuthUserViewModel(
            authenticationService: Provider.of(context)),
        builder: (context, model, widget) => Scaffold(
              backgroundColor: theme.backgroundColor,
              appBar: AppBar(
                backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
                iconTheme:
                    IconThemeData(color: theme.textTheme.headline4.color),
                title: Text(
                  "Suppression de compte",
                  style: TextStyle(color: theme.textTheme.headline4.color),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: KeyboardUtils.isHidden(context),
                      child: Text(
                        "Veuillez vous authentifier à nouveau afin de valider votre choix de supprimer votre compte",
                        style:
                            theme.textTheme.headline1.copyWith(fontSize: 15.0),
                      ),
                    ),
                    Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          Visibility(
                            visible: model.error != null,
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  model.error ?? '',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15.0),
                                ),
                              ),
                            )),
                          ),
                          TextFieldWidget(
                            controller: model.emailController,
                            label: 'Identifiant',
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
                            validation: (value) =>
                                model.passwordValidator(value),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RoundedButton(
                            onTap: () => model.getCredentialsByEmail(),
                            color: AppColors.CircleAvatarBorderColor,
                            text: "Connexion",
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: KeyboardUtils.isHidden(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundLogoButton(
                              color: Colors.white,
                              logo: AppLogoImages.LogoGoogle,
                              size: 50.0,
                              onTap: () => model.getCredentialsByGoogle()),
                          Visibility(
                            visible: Platform.isIOS,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: RoundLogoButton(
                                  color: Colors.white,
                                  logo: AppLogoImages.LogoApple,
                                  size: 50.0,
                                  onTap: () => model.getCredentialsByApple()),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
