import 'package:flutter/material.dart';

class AuthTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  final bool obscurePass;
  const AuthTextForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscurePass = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscurePass,

      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing ";
        }
        return null;
      },
    );
  }
}
