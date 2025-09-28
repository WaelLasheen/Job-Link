import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: theme.blue),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        hintStyle: theme.hintStyle,
      ),
      style: theme.textFieldStyle,
      keyboardType: keyboardType,
    );
  }
}
