part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

// Load all messages:
final class LoadMessageRequested extends ChatEvent {
  final String chatId;

  LoadMessageRequested(this.chatId);
}

// Send message requested:
final class SendMessageRequested extends ChatEvent {
  final String chatId;
  final Message message;

  SendMessageRequested(this.chatId, this.message);
}

// Delete message requested:
final class DeleteMessageRequested extends ChatEvent {
  final String chatId;
  final String messageId;

  DeleteMessageRequested(this.chatId, this.messageId);
}

// Subscribe to real-time updates:
final class SubscribeToMessages extends ChatEvent {
  final String chatId;
  SubscribeToMessages(this.chatId);
}

// Internally used when new messages arrive from Firestore stream:
final class MessagesUpdated extends ChatEvent {
  final List<Message> messages;
  MessagesUpdated(this.messages);
}
