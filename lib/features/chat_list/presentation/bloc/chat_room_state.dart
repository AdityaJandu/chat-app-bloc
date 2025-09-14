part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomState {}

final class ChatRoomInitial extends ChatRoomState {}

final class ChatRoomLoading extends ChatRoomState {}

final class ChatRoomLoaded extends ChatRoomState {
  final List<ChatRoom> chatRooms;

  ChatRoomLoaded(this.chatRooms);
}

final class ChatRoomError extends ChatRoomState {
  final String error;

  ChatRoomError(this.error);
}
