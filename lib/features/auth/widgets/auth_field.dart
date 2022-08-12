import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool isProtected;

  const AuthField({
    super.key,
    required this.controller,
    this.isProtected = false,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
      controller: controller,
      obscureText: isProtected,
    );
  }
}
