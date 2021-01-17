import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/login_view_model.dart';
import 'package:match_work/ui/shared/app_colors.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/views/root.dart';
import 'package:match_work/ui/views/sign_in_view.dart';
import 'package:match_work/ui/views/sign_up_view.dart';
import 'package:match_work/ui/widgets/round_logo_button.dart';
import 'package:match_work/ui/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/background_connexion_night.png"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/logo/logo_text_below.png",
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Column(
                        children: [
                          RoundedButton(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(SignUpView.route),
                              color: ACCENT_COLOR,
                              text: "Inscription",
                              textColor: Colors.white),
                          SizedBox(
                            height: 15.0,
                          ),
                          RoundedButton(
                            onTap: () => Navigator.of(context)
                                .pushNamed(SignInView.route),
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
                                  logo: 'assets/images/logo/google_logo.png',
                                  size: 50.0,
                                  onTap: () => model
                                          .loginWithGoogle()
                                          .then((bool success) {
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
                                      })),
                              SizedBox(width: 15.0,),
                              RoundLogoButton(
                                  color: Colors.white,
                                  logo: 'assets/images/logo/linkedin_logo.png',
                                  size: 50.0,
                                  onTap: () => null)
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
