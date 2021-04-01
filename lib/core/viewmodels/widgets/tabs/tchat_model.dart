import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

class TchatModel extends BaseModel {
  final AuthenticationService _authenticationService;

  final ConversationRepository _conversationRepository =
      ConversationRepository();
  final UserRepository _userRepository = UserRepository();
  final MatchRequestRepository _matchRequestRepository =
      MatchRequestRepository();
  final TextEditingController searchController = TextEditingController();
  String searchText = "";

  BehaviorSubject<List<Conversation>> _conversationsSubject =
      BehaviorSubject<List<Conversation>>.seeded([]);
  Function(List<Conversation>) get _inConversations =>
      _conversationsSubject.sink.add;
  Stream<List<Conversation>> get outConversations =>
      _conversationsSubject.stream;

  BehaviorSubject<List<MatchRequest>> _matchRequestsSubject =
      BehaviorSubject<List<MatchRequest>>.seeded([]);
  Function(List<MatchRequest>) get _inMatchRequests =>
      _matchRequestsSubject.sink.add;
  Stream<List<MatchRequest>> get outMatchRequests =>
      _matchRequestsSubject.stream;

  TchatModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  StreamSubscription listenConversationsStream() {
    String authenticatedUserUid = _authenticationService.currentUser.uid;
    return _conversationRepository
        .getConversationsStream(userId: authenticatedUserUid)
        .listen((List<Conversation> conversations) {
      if (!_conversationsSubject.isClosed) {
        _inConversations(conversations ?? []);
      }
    });
  }

  StreamSubscription listenMatchRequestsStream() {
    String authenticatedUserUid = _authenticationService.currentUser.uid;
    return _matchRequestRepository
        .getMatchRequestsStream(userUid: authenticatedUserUid)
        .listen((List<MatchRequest> matchRequests) {
      if (!_conversationsSubject.isClosed) {
        _inMatchRequests(matchRequests ?? []);
      }
    });
  }

  void onChangeSearch() {
    busy = true;
    searchText = searchController.text;
    busy = false;
  }

  Future<User> search() async {
    busy = true;
    User user = await _userRepository.getUserByMail(searchController.text);
    searchController.clear();
    searchText = searchController.text;
    busy = false;
    return user;
  }

  bool isConversationToDisplay(Conversation conversation) {
    bool isDeleted = false;
    conversation.isDeletedList?.forEach((element) {
      ParticipantInfoConversation participantInfo =
          ParticipantInfoConversation.fromJson(element);
      if (participantInfo.userUid == _authenticationService.currentUser.uid) {
        isDeleted = true;
      }
    });

    if (isDeleted) {
      return false;
    }
    if (searchText.isNotEmpty) {
      return conversation.caller
          .displayName()
          .toUpperCase()
          .contains(searchText.toUpperCase());
    }
    return true;
  }

  Future<String> removeConversation(
      {@required Conversation conversation}) async {
    bool success = await _conversationRepository.removeConversation(
        conversation: conversation,
        currentUserUid: _authenticationService.currentUser.uid);
    if (success) {
      return "Conversation supprimée";
    } else {
      return "Une erreur s'est produite";
    }
  }

  Future acceptMatchRequest({@required MatchRequest matchRequest}) async {
    Conversation conversation = Conversation(
      senderUid: matchRequest.senderUid,
      receiverUid: matchRequest.recipientUid,
      lastMessageCreatedAt: Timestamp.now(),
    );
    conversation.id = ConversationsUtils.getConversationId(
        receiverId: conversation.receiverUid, senderId: conversation.senderUid);
    return await _conversationRepository
        .createConversation(conversation: conversation)
        .then((value) async => await _matchRequestRepository.removeMatchRequest(
            matchRequest: matchRequest));
  }

  Future rejectMatchRequest({@required MatchRequest matchRequest}) async =>
      await _matchRequestRepository.removeMatchRequest(
          matchRequest: matchRequest);

  @override
  void dispose() {
    super.dispose();
    _conversationsSubject.close();
    _matchRequestsSubject.close();
  }
}
