import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class JobApplicationDetailsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const JobApplicationDetailsCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.subtitleStyle.copyWith(color: theme.chipColor),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}
