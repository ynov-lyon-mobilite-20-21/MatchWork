import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class ProfileModel extends BaseModel {
  final AuthenticationService _authenticationService;
  User user;

  ProfileModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  UserRepository _userRepository = UserRepository();

  StreamSubscription listenUserStream() {
    user = _authenticationService.currentUser;
    getInfoUser();
    return _authenticationService.outUser.listen((User user) {
      this.user = user;
      getInfoUser().then((value) => busy = false);
    });
  }

  Future<void> getInfoUser() async {
    busy = true;

    if (user.skills == null ||
        user.formations == null ||
        user.experiences == null) {
      user.skills = [];
      user.formations = [];
      user.experiences = [];
    }

    user.skills = await _userRepository.getSkillsByUser(user);
    user.experiences = await _userRepository.getExperiencesByUser(user);
    user.formations = await _userRepository.getFormationsByUser(user);

    user.sortExperiences();
    user.sortFormations();

    busy = false;
  }
}
