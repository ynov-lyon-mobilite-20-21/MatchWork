import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class TchatModel extends BaseModel {
  final AuthenticationService _authenticationService;
  final ConversationRepository _conversationRepository =
      ConversationRepository();

  TchatModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Stream<List<Conversation>> getConversations() => _conversationRepository
      .getConversationsStream(userId: _authenticationService.currentUser.uid);
}
