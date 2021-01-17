import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/sign_in_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/root.dart';
import 'package:match_work/ui/views/sign_up_view.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  static const route = 'signIn';

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignInViewModel>(
      model: SignInViewModel(
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
                    Image.asset(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? "assets/images/welcome_white.png"
                          : "assets/images/welcome_blue.png",
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: model.emailController,
                            color: Colors.white,
                            label: 'Identifiant',
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
                            height: 20.0,
                          ),
                          model.busy
                              ? CircularProgressIndicator()
                              : RoundedButton(
                                  onTap: () {
                                    if (model.formKey.currentState.validate()) {
                                      model.signIn().then((bool success) {
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
                                  color: Colors.transparent,
                                  text: "Connexion",
                                  textColor: Theme.of(context).indicatorColor,
                                  border: Border.all(
                                      color: Theme.of(context).indicatorColor),
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Pas encore de compte?",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16.0),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(SignUpView.route),
                            child: Text(
                              "Inscrivez-vous",
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
