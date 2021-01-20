import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/form_validators.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class SignInViewModel extends BaseModel {
  final AuthenticationService _authenticationService;
  String error;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> signIn() async {
    busy = true;
    error = await _authenticationService.signInWithEmailAndPassword(
        emailController.text, passwordController.text);
    busy = false;
    return error == null;
  }

  String emailValidator(String email) {
    String error = FormValidators.isNotEmpty(email);
    return error != null ? error : FormValidators.isEmail(email);
  }

  String passwordValidator(String password) {
    return FormValidators.isNotEmpty(password);
  }
}
