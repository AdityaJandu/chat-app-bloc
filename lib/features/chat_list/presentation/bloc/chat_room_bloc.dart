import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/features/chat_list/domain/entities/chat_room.dart';
import 'package:chat_app_bloc/features/chat_list/domain/repos/chat_room_repo.dart';
import 'package:meta/meta.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatRoomRepo chatRoomRepo;

  ChatRoomBloc({required this.chatRoomRepo}) : super(ChatRoomLoading()) {
    // Load all chat rooms once
    on<LoadChatRoomsRequested>((event, emit) async {
      emit(ChatRoomLoading());
      try {
        final chatRooms = await chatRoomRepo.getAllUser();
        emit(ChatRoomLoaded(chatRooms));
      } catch (e) {
        emit(ChatRoomError("Failed to load chat rooms: $e"));
      }
    });

    // Subscribe to real-time updates
    on<SubscribeToChatRooms>((event, emit) async {
      emit(ChatRoomLoading());
      try {
        await emit.forEach<List<ChatRoom>>(
          chatRoomRepo.getStreamUser(),
          onData: (chatRooms) => ChatRoomLoaded(chatRooms),
          onError: (error, _) => ChatRoomError("Stream error: $error"),
        );
      } catch (e) {
        emit(ChatRoomError("Failed to subscribe: $e"));
      }
    });

    // Add a new chat room
    on<AddChatRoomRequested>((event, emit) async {
      try {
        await chatRoomRepo.addNewUser(event.uid1, event.uid2);
        // Optionally refresh list
        add(LoadChatRoomsRequested());
      } catch (e) {
        emit(ChatRoomError("Failed to add chat room: $e"));
      }
    });

    // Remove a chat room
    on<RemoveChatRoomRequested>((event, emit) async {
      try {
        await chatRoomRepo.removeUser(event.chatRoom);
        add(LoadChatRoomsRequested());
      } catch (e) {
        emit(ChatRoomError("Failed to remove chat room: $e"));
      }
    });
  }
}
