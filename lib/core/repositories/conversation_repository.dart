import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/models/chat_message.dart';
import 'package:match_work/core/models/conversation.dart';
import 'package:match_work/core/utils/conversation_utils.dart';

class ConversationRepository {
  final CollectionReference _conversationsCollection =
      FirebaseFirestore.instance.collection('conversations');

  Future<Conversation> getConversationById(String idConversation) async {
    DocumentSnapshot snapshot =
        await _conversationsCollection.doc(idConversation).get();
    return Conversation.fromSnapshot(snapshot);
  }

  Stream<List<ChatMessage>> getMessagesStream(String idConversation) {
    return _conversationsCollection
        .doc(idConversation)
        .collection('messages')
        .orderBy('createdAt', descending: true)
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
          .collection("messages")
          .add(message.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
