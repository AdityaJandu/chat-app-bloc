import 'package:chat_app_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_bloc/widgets/login_field.dart';
import 'package:chat_app_bloc/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.togglePages});

  final VoidCallback togglePages;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    // Auth Bloc:
    final authBloc = context.read<AuthBloc>();

    // Prepare data:
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Check if data is alright: Not empty:
    if (email.isNotEmpty && password.isNotEmpty) {
      authBloc.add(
        AuthLoginRequested(
          email: email,
          password: password,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 50),
              LoginField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              MyButton(
                onPressed: _login,
                text: "Log-in",
                pd: 50,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => widget.togglePages(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account. "),
                    Text(
                      "Create one now!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
