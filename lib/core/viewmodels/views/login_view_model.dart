import 'package:flutter/foundation.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService;
  String error;

  LoginViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> loginWithGoogle() async {
    busy = true;
    error = await _authenticationService.signInWithGoogle();
    busy = false;
    return error == null;
  }
}
