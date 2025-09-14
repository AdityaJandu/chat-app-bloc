part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

// Initial State:
final class ChatInitial extends ChatState {}

// Loading chats:
final class ChatLoading extends ChatState {}

// Chats are loaded:
final class ChatLoaded extends ChatState {
  final List<Message> message;

  ChatLoaded(this.message);
}

// When a new message is being sent
final class ChatSending extends ChatState {}

// Error while loading chats:
final class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
