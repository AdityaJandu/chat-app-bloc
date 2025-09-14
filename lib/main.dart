import 'package:chat_app_bloc/features/auth/data/firebase_auth_repo.dart';
import 'package:chat_app_bloc/features/auth/data/firebase_firestore_repo.dart';
import 'package:chat_app_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_bloc/features/auth/presentation/screens/auth_screen.dart';
import 'package:chat_app_bloc/features/chat/data/firestore_message_repo.dart';
import 'package:chat_app_bloc/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app_bloc/features/chat_list/presentation/screens/home_screen.dart';
import 'package:chat_app_bloc/features/chat_list/data/firestore_chat_room_repo.dart';
import 'package:chat_app_bloc/features/chat_list/presentation/bloc/chat_room_bloc.dart';
import 'package:chat_app_bloc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final firebaseAuthRepo = FirebaseAuthRepo();
  final firebaseFirestoreRepo = FirebaseFirestoreRepo();
  final firebaseChatRoomRepo = FirestoreChatRoomRepo();
  final firestoreMessageRepo = FirestoreMessageRepo();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepo: firebaseAuthRepo,
            userRepo: firebaseFirestoreRepo,
          )..add(
              AuthCheckStatusRequested(),
            ),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(
            messageRepo: firestoreMessageRepo,
          ),
        ),
        BlocProvider<ChatRoomBloc>(
          create: (context) => ChatRoomBloc(
            chatRoomRepo: firebaseChatRoomRepo,
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            // if unauthenticated:
            if (state is Unauthenticated) {
              return const AuthScreen();
            }

            // if Authenticated:
            if (state is Authenticated) {
              return const HomeScreen();
            }

            // if Loading:
            else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
