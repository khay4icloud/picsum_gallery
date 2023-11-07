import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool maskText;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.maskText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validator != null) return validator!(value);
      },
      controller: controller,
      obscureText: maskText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
