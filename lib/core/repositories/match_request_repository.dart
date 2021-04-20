import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/models/match_request.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class MatchRequestRepository {
  static String senderUidReference = 'senderUid';
  static String recipientUidReference = 'recipientUid';
  static String createdAtReference = 'createdAt';

  final CollectionReference _matchRequestsCollection =
      FirebaseFirestore.instance.collection('matchs');

  final UserRepository _userRepository = UserRepository();

  Future sendRequest({@required MatchRequest matchRequest}) async =>
      await _matchRequestsCollection
          .doc(matchRequest.id)
          .set(matchRequest.toJson());

  Stream<List<MatchRequest>> getMatchRequestsStream(
          {@required String userUid}) =>
      _matchRequestsCollection
          .where(recipientUidReference, isEqualTo: userUid)
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.length == 0) return [];
        return Future.wait(
            querySnapshot.docs.map((DocumentSnapshot documentSnapshot) async {
          MatchRequest matchRequest =
              MatchRequest.fromSnapshot(documentSnapshot);
          matchRequest.user =
              await _userRepository.getUserByUid(matchRequest.senderUid);
          return matchRequest;
        }));
      });

  Future removeMatchRequest({@required MatchRequest matchRequest}) async =>
      await _matchRequestsCollection.doc(matchRequest.id).delete();

  Future removeMatchRequestsByUser({@required User user}) async {
    QuerySnapshot snapshot = await _matchRequestsCollection
        .where(senderUidReference, isEqualTo: user.uid)
        .get();
    snapshot.docs.forEach((DocumentSnapshot documentSnapshot) async =>
        await this.removeMatchRequest(
            matchRequest: MatchRequest.fromSnapshot(documentSnapshot)));

    QuerySnapshot snapshot2 = await _matchRequestsCollection
        .where(recipientUidReference, isEqualTo: user.uid)
        .get();
    snapshot2.docs.forEach((DocumentSnapshot documentSnapshot) async =>
        await this.removeMatchRequest(
            matchRequest: MatchRequest.fromSnapshot(documentSnapshot)));
  }

  Stream<int> getNumberMatchRequests({@required User user}) =>
      _matchRequestsCollection
          .where(recipientUidReference, isEqualTo: user.uid)
          .snapshots()
          .map((QuerySnapshot querySnapshot) => querySnapshot.docs.length);
}
