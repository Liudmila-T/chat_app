import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;

  const AppTextField({super.key, required this.controller, required this.labelText, this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }
}
