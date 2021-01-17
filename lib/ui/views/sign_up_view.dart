import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/sign_up_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/root.dart';
import 'package:match_work/ui/views/sign_in_view.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  static const route = 'signUp';

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignUpViewModel>(
      model: SignUpViewModel(
          authenticationService: Provider.of<AuthenticationService>(context)),
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Provider.of<ThemeProvider>(context)
                          .isDarkMode
                      ? "assets/images/background/background_connexion_night.png"
                      : "assets/images/background/background_connexion_day.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Inscription",
                      style: TextStyle(
                          color: Theme.of(context).indicatorColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.0),
                    ),
                    Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: model.nameController,
                            color: Colors.white,
                            label: 'Nom',
                            validation: (value) => model.nameValidator(value),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFieldWidget(
                            controller: model.firstNameController,
                            color: Colors.white,
                            label: 'Prénom',
                            validation: (value) => model.nameValidator(value),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFieldWidget(
                            controller: model.emailController,
                            color: Colors.white,
                            label: 'Email',
                            inputType: TextInputType.emailAddress,
                            validation: (value) => model.emailValidator(value),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFieldWidget(
                            controller: model.passwordController,
                            color: Colors.white,
                            isObscureText: true,
                            label: 'Mot de passe',
                            validation: (value) =>
                                model.passwordValidator(value),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFieldWidget(
                            controller: model.confirmationController,
                            color: Colors.white,
                            isObscureText: true,
                            label: 'Confirmation du mot de passe',
                            validation: (value) =>
                                model.confirmationValidator(value),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          model.busy
                              ? CircularProgressIndicator()
                              : RoundedButton(
                                  onTap: () {
                                    if (model.formKey.currentState.validate()) {
                                      model.signUp().then((bool success) {
                                        if (success) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  Root.route, (route) => false);
                                        } else {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(model.error),
                                          ));
                                        }
                                      });
                                    }
                                  },
                                  color: ACCENT_COLOR,
                                  text: "Enregistrer",
                                  textColor: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).indicatorColor),
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Déjà un compte?",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16.0),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(SignInView.route),
                            child: Text(
                              "Connectez-vous",
                              style: TextStyle(
                                  color: Theme.of(context).indicatorColor),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
