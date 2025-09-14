import 'package:chat_app_bloc/features/chat_list/domain/entities/chat_room.dart';
import 'package:chat_app_bloc/features/chat_list/domain/repos/chat_room_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreChatRoomRepo extends ChatRoomRepo {
  final chatRoomsCollection =
      FirebaseFirestore.instance.collection('chat-rooms');

  @override
  Future<void> addNewUser(String uid1, String uid2) async {
    try {
      final sortedIds = [uid1, uid2]..sort();
      final chatRoomId = sortedIds.join('_');

      final chatRoomDoc = chatRoomsCollection.doc(chatRoomId);
      final docSnapshot = await chatRoomDoc.get();

      if (!docSnapshot.exists) {
        await chatRoomDoc.set({'participants': sortedIds});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Get all chat rooms
  @override
  Future<List<ChatRoom>> getAllUser() async {
    try {
      final snapshot = await chatRoomsCollection.get();
      return snapshot.docs
          .map((doc) => ChatRoom.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Failed to get chat rooms: $e");
    }
  }

  // Stream of chat rooms (real-time updates)
  @override
  Stream<List<ChatRoom>> getStreamUser() {
    try {
      return chatRoomsCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => ChatRoom.fromMap(doc.data(), doc.id))
          .toList());
    } catch (e) {
      throw Exception("Failed to stream chat rooms: $e");
    }
  }

  @override
  Future<void> removeUser(ChatRoom chatRoom) async {
    try {
      await chatRoomsCollection.doc(chatRoom.id).delete();
    } catch (e) {
      throw Exception("Failed to remove user: $e");
    }
  }
}
