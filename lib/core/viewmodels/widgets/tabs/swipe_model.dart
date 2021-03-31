import 'dart:async';

import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class SwipeModel extends BaseModel {
  List<User> users = [];

  BehaviorSubject<List<User>> _usersSubject =
  BehaviorSubject<List<User>>.seeded([]);

  Function(List<User>) get _inUsers => _usersSubject.sink.add;

  Stream<List<User>> get outUsers => _usersSubject.stream;

  final UserRepository _userRepository = UserRepository();

  StreamSubscription listenUsers() =>
      _userRepository.getAllUsersStream().listen((List<User> users) {
        if (users.length > 0 && !_usersSubject.isClosed) {
          _inUsers(users);
          this.users = users;
          notifyListeners();
        }
      });

  Future<User> getInfosByUser(User user) async {
    busy = true;
    user.skills = await _userRepository.getSkillsByUser(user);
    user.formations = await _userRepository.getFormationsByUser(user);
    user.experiences = await _userRepository.getExperiencesByUser(user);
    busy = false;
    return user;
  }

  @override
  void dispose() {
    super.dispose();
    _usersSubject.close();
  }
}
