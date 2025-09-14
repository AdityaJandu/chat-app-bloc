import 'package:chat_app_bloc/features/chat/domain/entities/message.dart';
import 'package:chat_app_bloc/features/chat/domain/repos/message_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessageRepo messageRepo;
  ChatBloc({required this.messageRepo}) : super(ChatInitial()) {
    on<SendMessageRequested>(_onSendRequested);
    on<LoadMessageRequested>(_loadMessageRequested);
    on<SubscribeToMessages>(_subscribeToMessages);
    on<DeleteMessageRequested>(_deleteMessageRequested);
  }

  // send message:
  Future<void> _onSendRequested(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      await messageRepo.addNewMessage(event.chatId, event.message);

      print('hua hai kuch');
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  // Load messages:
  Future<void> _loadMessageRequested(
      LoadMessageRequested event, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    try {
      await emit.forEach<List<Message>>(
        messageRepo.readRealTimeMessage(event.chatId),
        onData: (messages) => ChatLoaded(messages),
        onError: (error, _) => ChatError(error.toString()),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _subscribeToMessages(
      SubscribeToMessages event, Emitter<ChatState> emit) async {
    await emit.forEach<List<Message>>(
      messageRepo.readRealTimeMessage(event.chatId),
      onData: (messages) => ChatLoaded(messages),
      onError: (error, _) => ChatError(error.toString()),
    );
  }

  Future<void> _deleteMessageRequested(
      DeleteMessageRequested event, Emitter<ChatState> emit) async {
    try {
      await messageRepo.deleteMessage(event.chatId, event.messageId);
    } catch (e) {
      emit(ChatError("Failed to delete message: $e"));
    }
  }
}
