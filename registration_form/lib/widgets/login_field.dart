import 'package:flutter/material.dart';
import 'package:registration_form/palette.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  const LoginField({super.key, required this.hintText, required this.controller, this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Pallete.borderColor, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Pallete.gradient2, width: 3),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Pallete.whiteColor, fontSize: 16),
        ),
        
      ),
    );
  }
}
