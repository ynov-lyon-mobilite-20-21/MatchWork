import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class TchatModel extends BaseModel {
  final AuthenticationService _authenticationService;

  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final UserRepository _userRepository = UserRepository();
  final TextEditingController searchController = TextEditingController();

  BehaviorSubject<List<Conversation>> _conversationsSubject =
      BehaviorSubject<List<Conversation>>.seeded([]);

  Function(List<Conversation>) get _inConversations =>
      _conversationsSubject.sink.add;

  Stream<List<Conversation>> get outConversations =>
      _conversationsSubject.stream;

  TchatModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  StreamSubscription listenConversationsStream() {
    String authenticatedUserUid = _authenticationService.currentUser.uid;
    return _conversationRepository
        .getConversationsStream(userId: authenticatedUserUid)
        .listen((List<Conversation> conversations) {
      _inConversations(conversations ?? []);
    });
  }

  Future<User> search() async {
    busy = true;
    String search = searchController.text;
    User user = await _userRepository.getUserByMail(search);
    busy = false;
    return user;
  }

  @override
  void dispose() {
    super.dispose();
    _conversationsSubject.close();
  }
}