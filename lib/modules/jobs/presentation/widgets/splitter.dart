import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class Splitter extends StatelessWidget {
  const Splitter({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Divider(color: theme.dividerColor),
    );
  }
}
