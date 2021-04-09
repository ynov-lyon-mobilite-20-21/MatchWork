import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/match_request_repository.dart';

class MatchRequest {
  String id;
  String senderUid;
  String recipientUid;
  Timestamp createdAt;

  User user;

  MatchRequest(
      {this.id,
      @required this.senderUid,
      @required this.recipientUid,
      @required this.createdAt});

  MatchRequest.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        senderUid = snapshot.data()[MatchRequestRepository.senderUidReference],
        recipientUid =
            snapshot.data()[MatchRequestRepository.recipientUidReference],
        createdAt = snapshot.data()[MatchRequestRepository.createdAtReference];

  Map<String, dynamic> toJson() => {
        MatchRequestRepository.senderUidReference: senderUid,
        MatchRequestRepository.recipientUidReference: recipientUid,
        MatchRequestRepository.createdAtReference: createdAt,
      };
}
