import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';
import 'package:match_work/core/utils/conversation_utils.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';

class ConversationViewModel extends BaseModel {
  User caller;
  final TextEditingController controller = TextEditingController();
  final ConversationRepository _conversationRepository =
      ConversationRepository();
  List<ChatMessage> sendingMessages = []; //Liste des messages en cours d'envoi

  BehaviorSubject<List<ChatMessage>> _messagesSubject =
      BehaviorSubject<List<ChatMessage>>.seeded([]);

  Function(List<ChatMessage>) get _inMessages => _messagesSubject.sink.add;

  Stream<List<ChatMessage>> get outMessages => _messagesSubject.stream;

  ConversationViewModel({@required this.caller});

  StreamSubscription listenMessageStream(String authenticatedUserUid) {
    String idConversation = ConversationsUtils.getConversationId(
        receiverId: authenticatedUserUid, senderId: caller.uid);
    return _conversationRepository
        .getMessagesStream(idConversation)
        .listen((List<ChatMessage> messages) {
      _inMessages(messages ?? []);
      sendingMessages.forEach((ChatMessage sendingMessage) {
        if (messages
            .map((ChatMessage message) => message.content)
            .contains(sendingMessage.content)) {
          sendingMessages.remove(sendingMessage);
          notifyListeners();
        }
      });
    });
  }

  void sendMessage(String authenticatedUserUid) {
    ChatMessage message = ChatMessage(
        content: controller.text,
        createdAt: Timestamp.now(),
        ownerId: authenticatedUserUid);
    sendingMessages.add(message);
    notifyListeners();
    _conversationRepository.sendMessage(
        authenticatedUserUid, caller.uid, message);
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubject.close();
  }
}
