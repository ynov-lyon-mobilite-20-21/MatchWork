import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/models/match_request.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';
import 'package:match_work/core/repositories/match_request_repository.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/conversation_utils.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class SwipeModel extends BaseModel {
  final AuthenticationService _authenticationService;

  SwipeModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  final UserRepository _userRepository = UserRepository();
  final MatchRequestRepository _matchRequestRepository =
      MatchRequestRepository();
  final ConversationRepository _conversationRepository =
      ConversationRepository();

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

  Future<bool> hasConversation({@required User user}) async {
    String conversationId = ConversationsUtils.getConversationId(
        senderId: _authenticationService.currentUser.uid, receiverId: user.uid);
    Conversation conversation =
        await _conversationRepository.getConversationById(conversationId);
    return conversation != null;
  }

  Future matchUser({@required User user}) async {
    MatchRequest matchRequest = MatchRequest(
        id: ConversationsUtils.getConversationId(
            senderId: _authenticationService.currentUser.uid,
            receiverId: user.uid),
        senderUid: _authenticationService.currentUser.uid,
        recipientUid: user.uid,
        createdAt: Timestamp.now());
    return await _matchRequestRepository.sendRequest(
        matchRequest: matchRequest);
  }

  @override
  void dispose() {
    super.dispose();
    _usersSubject.close();
  }
}
