import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';

class Conversation {
  String id;
  String senderUid;
  String receiverUid;
  String lastMessageContent;
  Timestamp lastMessageCreatedAt;
  bool isRead;

  User caller;

  Conversation(
      {this.id,
      @required this.senderUid,
      @required this.receiverUid,
      @required this.lastMessageContent,
      @required this.lastMessageCreatedAt,
      this.isRead = false});

  Conversation.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        senderUid = snapshot
            .data()[ConversationRepository.conversationSenderUidReference],
        receiverUid = snapshot
            .data()[ConversationRepository.conversationReceiverUidReference],
        lastMessageContent = snapshot.data()[
            ConversationRepository.conversationLastMessageContentReference],
        lastMessageCreatedAt = snapshot.data()[
            ConversationRepository.conversationLastMessageCreatedAtReference],
        isRead =
            snapshot.data()[ConversationRepository.conversationIsReadReference];

  Map<String, dynamic> toJson() => {
        ConversationRepository.conversationSenderUidReference: senderUid,
        ConversationRepository.conversationReceiverUidReference: receiverUid,
        ConversationRepository.conversationLastMessageContentReference:
            lastMessageContent,
        ConversationRepository.conversationLastMessageCreatedAtReference:
            lastMessageCreatedAt,
        ConversationRepository.conversationIsReadReference: isRead
      };
}
