import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/form_validators.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class RemoveAuthUserViewModel extends BaseModel {
  final AuthenticationService _authenticationService;

  String error;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RemoveAuthUserViewModel(
      {@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<String> removeAuthUser(AuthCredential credential) async =>
      await _authenticationService.removeUserAuth(credential: credential);

  Future getCredentialsByEmail() async {
    if (formKey.currentState.validate()) {
      busy = true;

      bool isValid = true;
      AuthCredential credential = EmailAuthProvider.credential(
          email: emailController.text.trim(),
          password: passwordController.text);
      isValid = await _authenticationService.testCredential(credential);
      if (isValid) {
        error = await removeAuthUser(credential);
      } else {
        error = "Identifiants invalides";
      }

      busy = false;
    }
  }

  Future getCredentialsByGoogle() async {
    busy = true;

    bool isValid = true;
    final credential = await _authenticationService.getGoogleCredential();
    isValid = await _authenticationService.testCredential(credential);
    if (isValid) {
      error = await removeAuthUser(credential);
    } else {
      error = "Echec de la connexion à Google";
    }

    busy = false;
  }

  Future getCredentialsByApple() async {
    busy = true;

    bool isValid = true;
    final credential = await _authenticationService.getAppleCredential();
    isValid = await _authenticationService.testCredential(credential);
    if (isValid) {
      error = await removeAuthUser(credential);
    } else {
      error = "Echec de la connexion à Apple";
    }

    busy = false;
  }

  String emailValidator(String email) {
    String error = FormValidators.isNotEmpty(email);
    return error != null ? error : FormValidators.isEmail(email);
  }

  String passwordValidator(String password) {
    return FormValidators.isNotEmpty(password);
  }
}
