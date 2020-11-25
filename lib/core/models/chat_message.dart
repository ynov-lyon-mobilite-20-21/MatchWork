import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String content;
  Timestamp createdAt;
  String ownerId;

  ChatMessage(
      {@required this.content,
      @required this.createdAt,
      @required this.ownerId});
}
