import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class JobInfoSection extends StatelessWidget {
  final String title;
  final String freelancerName;
  const JobInfoSection({
    super.key,
    required this.title,
    required this.freelancerName,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.titleStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.person, size: 20, color: theme.grey),
            const SizedBox(width: 6),
            Text(freelancerName, style: theme.bodyStyle),
          ],
        ),
      ],
    );
  }
}