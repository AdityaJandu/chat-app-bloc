class Message {
  final String content;
  final String id; // This will store Firestore doc ID
  final String senderId;
  final String recieverId;

  Message({
    required this.content,
    required this.id,
    required this.senderId,
    required this.recieverId,
  });

  // Model -> JSON (do NOT include id, Firestore will generate it)
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'recieverId': recieverId,
    };
  }

  // JSON -> Model (from Firestore)
  factory Message.fromMap(Map<String, dynamic> map, String docId) {
    return Message(
      content: map['content'] ?? '',
      id: docId, // use Firestore document ID here
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
    );
  }
}
