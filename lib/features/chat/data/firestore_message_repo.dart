import 'package:chat_app_bloc/features/chat/domain/entities/message.dart';
import 'package:chat_app_bloc/features/chat/domain/repos/message_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessageRepo extends MessageRepo {
  final CollectionReference<Map<String, dynamic>> firebaseFirestore =
      FirebaseFirestore.instance.collection('chat-rooms');

  @override
  Future<void> addNewMessage(String chatId, Message message) async {
    try {
      // Do NOT include id here — Firestore generates it automatically
      await firebaseFirestore.doc(chatId).collection('messages').add(
            message.toMap(),
          );
    } catch (e) {
      throw Exception("Failed to add message: $e");
    }
  }

  @override
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      await firebaseFirestore
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception("Failed to delete message: $e");
    }
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    try {
      final querySnapshot =
          await firebaseFirestore.doc(chatId).collection('messages').get();

      return querySnapshot.docs
          .map((doc) => Message.fromMap(doc.data(), doc.id)) // ✅ Pass doc.id
          .toList();
    } catch (e) {
      throw Exception("Failed to get messages: $e");
    }
  }

  @override
  Stream<List<Message>> readRealTimeMessage(String chatId) {
    try {
      return firebaseFirestore
          .doc(chatId)
          .collection('messages')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Message.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      throw Exception("Failed to read messages: $e");
    }
  }
}
