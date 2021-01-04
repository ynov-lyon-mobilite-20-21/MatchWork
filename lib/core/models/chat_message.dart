import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String id;
  String content;
  Timestamp createdAt;
  String ownerId;

  ChatMessage(
      {this.id,
      @required this.content,
      @required this.createdAt,
      @required this.ownerId});

  ChatMessage.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        content = snapshot.data()['content'],
        createdAt = snapshot.data()['createdAt'],
        ownerId = snapshot.data()['ownerId'];

  Map<String, dynamic> toJson() =>
      {'content': content ?? '', 'createdAt': createdAt, 'ownerId': ownerId};
}
