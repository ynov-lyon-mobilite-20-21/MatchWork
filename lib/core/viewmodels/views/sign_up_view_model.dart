import 'package:flutter/material.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/form_validators.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService;
  String error;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();

  SignUpViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> signUp() async {
    busy = true;
    error = await _authenticationService.registrationWithEmailAndPassword(
        email: emailController.text.toLowerCase(),
        password: passwordController.text,
        firstName: firstNameController.text.toLowerCase(),
        name: nameController.text.toLowerCase());
    busy = false;
    return error == null;
  }

  String nameValidator(String name) {
    return FormValidators.isNotEmpty(name);
  }

  String emailValidator(String email) {
    String errorMessage = FormValidators.isNotEmpty(email);
    return errorMessage != null ? errorMessage : FormValidators.isEmail(email);
  }

  String passwordValidator(String password) {
    String errorMessage = FormValidators.isNotEmpty(password);
    return errorMessage != null
        ? errorMessage
        : FormValidators.isStrongPassword(password);
  }

  String confirmationValidator(String confirmation) {
    String errorMessage = FormValidators.isNotEmpty(confirmation);
    return errorMessage != null
        ? errorMessage
        : FormValidators.isSameValue(passwordController.text, confirmation);
  }
}
