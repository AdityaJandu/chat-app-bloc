import 'package:chat_app_bloc/features/chat_list/domain/entities/chat_room.dart';

abstract class ChatRoomRepo {
  // Add a new user to chat-room:
  Future<void> addNewUser(String uid1, String uid2);

  // Remove a user from chat-room:
  Future<void> removeUser(ChatRoom chatRoom);

  // Get all users in chatroom:
  Future<List<ChatRoom>> getAllUser();

  // Stream of users:
  Stream<List<ChatRoom>> getStreamUser();
}
