class ChatRoom {
  final String id; // doc ID
  final List<String> participants; // [senderId, receiverId]

  ChatRoom({
    required this.id,
    required this.participants,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map, String docId) {
    return ChatRoom(
      id: docId,
      participants: List<String>.from(map['participants'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
    };
  }
}
