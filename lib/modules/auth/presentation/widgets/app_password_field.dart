import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class AppPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppPasswordField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.blue),
        hintText: widget.hint,
        hintStyle: theme.hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        suffixIcon: IconButton(
          icon: _obscure
              ? const Icon(Icons.visibility_off, color: Colors.grey)
              : const Icon(Icons.visibility, color: Colors.blue),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
      style: theme.labelStyle,
    );
  }
}
