import 'package:flutter/foundation.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/form_validators.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;
  String error;
  bool _isRegistration = false;

  bool get isRegistration => _isRegistration;

  set isRegistration(bool value) {
    _isRegistration = value;
    notifyListeners();
  }

  LoginViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    busy = true;
    error = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    busy = false;
    return error == null;
  }

  Future<bool> loginWithGoogle() async {
    busy = true;
    error = await _authenticationService.signInWithGoogle();
    busy = false;
    return error == null;
  }

  Future<bool> registrationWithEmailAndPassword(
      String email, String password) async {
    busy = true;
    error = await _authenticationService.registrationWithEmailAndPassword(
        email, password);
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

  String confirmationValidator(String password, String confirmation) {
    String error = FormValidators.isNotEmpty(confirmation);
    return error != null
        ? error
        : FormValidators.isSameValue(password, confirmation);
  }
}
