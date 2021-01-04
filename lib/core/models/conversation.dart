import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Conversation {
  String idParticipant1;
  String idParticipant2;
  bool isRead;

  Conversation(
      {@required this.idParticipant1,
      @required this.idParticipant2,
      this.isRead = false});

  Conversation.fromSnapshot(DocumentSnapshot snapshot)
      : idParticipant1 = snapshot.data()['idParticipant1'],
        idParticipant2 = snapshot.data()['idParticipant2'],
        isRead = snapshot.data()['isRead'];

  Map<String, dynamic> toJson() => {
        'idParticipant1': idParticipant1,
        'idParticipant2': idParticipant2,
        'isRead': isRead
      };
}
