import 'package:chat_app_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app_bloc/widgets/login_field.dart';
import 'package:chat_app_bloc/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.togglePages});
  final VoidCallback togglePages;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // Register button pressed
  void _register() {
    // Prepare Info:
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();

    final authBloc = context.read<AuthBloc>();
    if (email.isNotEmpty && name.isNotEmpty && password.isNotEmpty) {
      authBloc.add(
        AuthSignUpRequested(
          email: email,
          password: password,
          name: name,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Naa mitr badmasi nhi'),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
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
                'Sign up.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 50),
              LoginField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 15),
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
                onPressed: _register,
                text: "Sign-up",
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
