import 'package:flutter/material.dart';
import 'package:chat_app_bloc/constants/consts.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.pd});
  final VoidCallback onPressed;
  final String text;
  final double pd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pd),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5F37EF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Consts().boldStyleMedium,
          ),
        ),
      ),
    );
  }
}
