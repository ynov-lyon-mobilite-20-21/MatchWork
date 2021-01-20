import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/keyboard_utils.dart';
import 'package:match_work/core/viewmodels/views/sign_up_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
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
    return BaseWidget<SignUpViewModel>(
      model: SignUpViewModel(
          authenticationService: Provider.of<AuthenticationService>(context)),
      builder: (_, model, __) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.StatusBarColor,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? AppImages.BackgroundLoginDark
                          : AppImages.BackgroundLoginLight),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: KeyboardUtils.isHidden(context)
                  ? Padding(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0,
                                        color: Colors.black54),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushReplacementNamed(RoutePath.Login),
                                    child: Text(
                                      "Connectez-vous",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).indicatorColor),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
            )
          ],
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
            validation: (value) => model.passwordValidator(value),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            controller: model.confirmationController,
            color: Colors.white,
            isObscureText: true,
            label: 'Confirmation du mot de passe',
            validation: (value) => model.confirmationValidator(value),
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
                  color: AppColors.AccentColor,
                  text: "Enregistrer",
                  textColor: Colors.white,
                ),
        ],
      ),
    );