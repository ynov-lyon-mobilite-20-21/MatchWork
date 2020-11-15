import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/view/root.dart';
import 'package:match_work/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoginViewModel>.value(
        value: LoginViewModel(authenticationService: Provider.of(context)),
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(model.isRegistration ? "Inscription" : "Connexion"),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (value) => model.emailValidator(value),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: "Mot de passe"),
                        validator: (value) => model.passwordValidator(value),
                      ),
                      model.isRegistration
                          ? TextFormField(
                              obscureText: true,
                              controller: _confirmationController,
                              decoration:
                                  InputDecoration(labelText: "Confirmation"),
                              validator: (value) => model.confirmationValidator(
                                  _passwordController.text, value),
                            )
                          : Container(),
                      model.busy
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              child: Text(model.isRegistration
                                  ? 'S\'inscrire'
                                  : 'Se connecter'),
                              onPressed: () async {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                bool success = model.isRegistration
                                    ? await model
                                        .registrationWithEmailAndPassword(
                                            email, password)
                                    : await model.loginWithEmailAndPassword(
                                        email, password);
                                validate(context, success, model.error);
                              },
                            ),
                      InkWell(
                        onTap: () =>
                            model.isRegistration = !model.isRegistration,
                        child: Text(
                          model.isRegistration
                              ? "Vous avez déjà un compte? Connectez-vous"
                              : "Pas encore de compte? Inscrivez-vous",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: Text("Google"),
                      onPressed: () async {
                        bool success = await model.loginWithGoogle();
                        validate(context, success, model.error);
                      },
                    ),
                    ElevatedButton(
                      child: Text("Linkedin"),
                      onPressed: () => null,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context, bool success, String error) {
    if (success) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Root()));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(error),
      ));
    }
  }
}
