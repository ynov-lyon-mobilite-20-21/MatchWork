class ConversationsUtils {
  static String getConversationId({String senderId, String receiverId}) {
    if (senderId.compareTo(receiverId) > 0) {
      return senderId + receiverId;
    } else {
      return receiverId + senderId;
    }
  }
}
