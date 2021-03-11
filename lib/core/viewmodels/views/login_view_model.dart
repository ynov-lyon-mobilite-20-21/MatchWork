import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future<bool> loginWithApple() async {
    busy = true;
    error = await _authenticationService.signInWithApple();
    busy = false;
    return error == null;
  }

  Future signOut() async {
    busy = true;
    await _authenticationService.signOut();
    busy = false;
  }
}
