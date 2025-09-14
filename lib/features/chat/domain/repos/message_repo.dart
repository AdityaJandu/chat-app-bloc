import 'package:chat_app_bloc/features/chat/domain/entities/message.dart';

abstract class MessageRepo {
  // Get all the messages:
  Future<List<Message>> getMessages(String chatId);

  // Add new message:
  Future<void> addNewMessage(String chatId, Message message);

  // Real time message listening:
  Stream<List<Message>> readRealTimeMessage(String chatId);

  // Delete message:
  Future<void> deleteMessage(String chatId, String messageId);

  // Mark as message read (Future):
}
