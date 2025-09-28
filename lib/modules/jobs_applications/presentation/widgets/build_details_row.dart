import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class BuildDetailsRow extends StatelessWidget {
  final String label;
  final String value;
  const BuildDetailsRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: theme.bodyStyle,
          children: [
            TextSpan(text: '$label: ', style: theme.labelStyle),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
