import 'package:chat_app_bloc/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app_bloc/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        togglePages: togglePages,
      );
    }

    return RegisterScreen(
      togglePages: togglePages,
    );
  }
}
