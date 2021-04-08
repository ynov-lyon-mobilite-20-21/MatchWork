import 'dart:async';

import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class SwipeModel extends BaseModel {
  final UserRepository _userRepository = UserRepository();
  final CardController controller = CardController();

  BehaviorSubject<List<User>> _usersSubject =
      BehaviorSubject<List<User>>.seeded([]);
  Function(List<User>) get _inUsers => _usersSubject.sink.add;
  Stream<List<User>> get outUsers => _usersSubject.stream;

  StreamSubscription listenUsers() =>
      _userRepository.getAllUsersStream().listen((List<User> users) {
        if (users.length > 0 && !_usersSubject.isClosed) {
          _inUsers(users ?? []);
        }
      });

  @override
  void dispose() {
    super.dispose();
    _usersSubject.close();
  }
}
