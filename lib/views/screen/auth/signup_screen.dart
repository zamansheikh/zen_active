import 'package:flutter/material.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/fcustom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FCustomTextField(
            isPassword: true,
            hintText: 'Enter your email',
            icon: Icons.email,
          ),
        ),
      ),
    );
  }
}
