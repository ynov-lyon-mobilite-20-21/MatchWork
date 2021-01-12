import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/repositories/conversation_repository.dart';

class ChatMessage {
  String id;
  String content;
  Timestamp createdAt;
  String ownerId;
  bool isRead;

  ChatMessage(
      {this.id,
      @required this.content,
      @required this.createdAt,
      @required this.ownerId,
      this.isRead = false});

  ChatMessage.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        content =
            snapshot.data()[ConversationRepository.messageContentReference],
        createdAt =
            snapshot.data()[ConversationRepository.messageCreatedAtReference],
        ownerId =
            snapshot.data()[ConversationRepository.messageOwnerIdReference],
        isRead = snapshot.data()[ConversationRepository.messageIsReadReference];

  Map<String, dynamic> toJson() => {
        ConversationRepository.messageContentReference: content ?? '',
        ConversationRepository.messageCreatedAtReference: createdAt,
        ConversationRepository.messageOwnerIdReference: ownerId,
        ConversationRepository.messageIsReadReference: isRead
      };
}
