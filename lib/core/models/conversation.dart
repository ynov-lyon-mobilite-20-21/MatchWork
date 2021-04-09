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
  List isDeletedList = [];
  List participantsAlreadyFirstReading = [];

  User caller;

  Conversation(
      {this.id,
      @required this.senderUid,
      @required this.receiverUid,
      this.lastMessageContent,
      this.lastMessageCreatedAt,
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
            snapshot.data()[ConversationRepository.conversationIsReadReference],
        isDeletedList = snapshot.data()[
            ConversationRepository.conversationParticipantInfoReference],
        participantsAlreadyFirstReading = snapshot.data()[ConversationRepository
            .conversationParticipantsAlreadyFirstReadingReference];

  Map<String, dynamic> toJson() => {
        ConversationRepository.conversationSenderUidReference: senderUid,
        ConversationRepository.conversationReceiverUidReference: receiverUid,
        ConversationRepository.conversationLastMessageContentReference:
            lastMessageContent,
        ConversationRepository.conversationLastMessageCreatedAtReference:
            lastMessageCreatedAt,
        ConversationRepository.conversationIsReadReference: isRead,
        ConversationRepository.conversationParticipantInfoReference:
            isDeletedList,
        ConversationRepository
                .conversationParticipantsAlreadyFirstReadingReference:
            participantsAlreadyFirstReading
      };
}

class ParticipantInfoConversation {
  String userUid;
  bool isDeleted = true;
  Timestamp deletionDate = Timestamp.now();

  ParticipantInfoConversation(this.userUid);

  ParticipantInfoConversation.fromJson(Map<String, dynamic> json)
      : userUid = json[
            ConversationRepository.conversationParticipantInfoUserUidReference],
        isDeleted = json[ConversationRepository
            .conversationParticipantInfoIsDeletedReference],
        deletionDate = json[ConversationRepository
            .conversationParticipantInfoDeletionDateReference];

  Map<String, dynamic> toJson() => {
        ConversationRepository.conversationParticipantInfoUserUidReference:
            userUid,
        ConversationRepository.conversationParticipantInfoIsDeletedReference:
            isDeleted,
        ConversationRepository.conversationParticipantInfoDeletionDateReference:
            deletionDate
      };
}
