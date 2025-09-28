import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? theme.chipColor,
        foregroundColor: theme.accentLighterBlue,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: theme.titleStyle.copyWith(color: theme.ofWhiteColor),
      ),
    );
  }
}
