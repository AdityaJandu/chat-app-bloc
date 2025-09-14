import 'package:chat_app_bloc/features/chat/presentation/screens/chat_screen.dart';
import 'package:chat_app_bloc/features/chat_list/presentation/bloc/chat_room_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Rooms")),
      body: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatRoomLoaded) {
            final chatRooms = state.chatRooms;

            if (chatRooms.isEmpty) {
              // Show a nice empty state UI
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No chat rooms yet",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Tap the + button to start a new chat",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                final otherUserId = chatRoom.participants.firstWhere(
                    (uid) => uid != "currentUserId"); // replace with auth uid

                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text("Chat with $otherUserId"),
                  subtitle: Text(chatRoom.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(chatRoomId: chatRoom.id),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ChatRoomError) {
            return Center(child: Text("Error: ${state.error}"));
          }

          // Fallback UI
          return const Center(child: Text("No data available"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: create a chat room with another user
          context.read<ChatRoomBloc>().add(
                AddChatRoomRequested(uid, "otherUserId"),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
