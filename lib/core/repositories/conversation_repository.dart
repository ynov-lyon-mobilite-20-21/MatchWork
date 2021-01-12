import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/utils/conversation_utils.dart';
import 'package:rxdart/rxdart.dart';

class ConversationRepository {
  static String messageContentReference = 'content';
  static String messageCreatedAtReference = 'createdAt';
  static String messageOwnerIdReference = 'ownerId';
  static String messageIsReadReference = 'isRead';

  static String conversationSenderUidReference = 'senderUid';
  static String conversationReceiverUidReference = 'receiverUid';
  static String conversationMessagesReference = 'messages';
  static String conversationLastMessageContentReference = 'lastMessageContent';
  static String conversationLastMessageCreatedAtReference =
      'lastMessageCreatedAt';
  static String conversationIsReadReference = 'isRead';

  final CollectionReference _conversationsCollection =
      FirebaseFirestore.instance.collection('conversations');

  final UserRepository _userRepository = UserRepository();

  Stream<List<Conversation>> getConversationsStream({@required String userId}) {
    Stream<QuerySnapshot> one = _conversationsCollection
        .where(conversationSenderUidReference, isEqualTo: userId)
        .snapshots();
    Stream<QuerySnapshot> two = _conversationsCollection
        .where(conversationReceiverUidReference, isEqualTo: userId)
        .snapshots();

    return Rx.combineLatest2(one, two, (QuerySnapshot q1, QuerySnapshot q2) {
      return [...q1.docs, ...q2.docs];
    }).asyncMap((List<DocumentSnapshot> listSnapshot) async =>
        Future.wait(listSnapshot.map((DocumentSnapshot snapshot) async {
          Conversation conversation = Conversation.fromSnapshot(snapshot);
          conversation.caller = await _userRepository.getUserByUid(
              userId == conversation.senderUid
                  ? conversation.receiverUid
                  : conversation.senderUid);
          return conversation;
        }).toList()));
  }

  Stream<Conversation> getConversationStream(
      {@required String conversationId}) {
    return _conversationsCollection.doc(conversationId).snapshots().asyncMap(
        (DocumentSnapshot snapshot) async =>
            Conversation.fromSnapshot(snapshot));
  }

  Future<Conversation> getConversationById(String conversationId) async {
    DocumentSnapshot snapshot =
        await _conversationsCollection.doc(conversationId).get();
    return Conversation.fromSnapshot(snapshot);
  }

  Stream<List<ChatMessage>> getMessagesStream(String idConversation) {
    return _conversationsCollection
        .doc(idConversation)
        .collection(conversationMessagesReference)
        .orderBy(messageCreatedAtReference, descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 0) return [];
      return querySnapshot.docs
          .map((DocumentSnapshot documentSnapshot) =>
              ChatMessage.fromSnapshot(documentSnapshot))
          .toList();
    });
  }

  Future<bool> sendMessage(
      String senderUid, String callerUid, ChatMessage message) async {
    try {
      String conversationId = ConversationsUtils.getConversationId(
          senderId: senderUid, receiverId: callerUid);
      await _conversationsCollection
          .doc(conversationId)
          .collection(conversationMessagesReference)
          .add(message.toJson())
          .then((value) => _conversationsCollection.doc(conversationId).set({
                conversationSenderUidReference: senderUid,
                conversationReceiverUidReference: callerUid,
                conversationLastMessageContentReference: message.content,
                conversationLastMessageCreatedAtReference: message.createdAt,
                conversationIsReadReference: false
              }, SetOptions(merge: true)));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readMessage(
          {@required String messageId,
          @required String conversationId}) async =>
      await _conversationsCollection
          .doc(conversationId)
          .collection(conversationMessagesReference)
          .doc(messageId)
          .update({messageIsReadReference: true})
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> readConversation({@required String conversationId}) async =>
      await _conversationsCollection
          .doc(conversationId)
          .update({conversationIsReadReference: true})
          .then((value) => true)
          .catchError((error) => false);
}
