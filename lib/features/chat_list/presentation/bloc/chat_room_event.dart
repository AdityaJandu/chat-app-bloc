part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomEvent {}

// Load all chat rooms once
final class LoadChatRoomsRequested extends ChatRoomEvent {}

// Subscribe to real-time updates
final class SubscribeToChatRooms extends ChatRoomEvent {}

// Add a new chat room between two users
final class AddChatRoomRequested extends ChatRoomEvent {
  final String uid1;
  final String uid2;

  AddChatRoomRequested(this.uid1, this.uid2);
}

// Remove a chat room
final class RemoveChatRoomRequested extends ChatRoomEvent {
  final ChatRoom chatRoom;

  RemoveChatRoomRequested(this.chatRoom);
}
