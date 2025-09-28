import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobSkills extends StatelessWidget {
  final Job job;

  const JobSkills({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Required Skills", style: theme.subtitleStyle),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: job.requiredSkills
              .map(
                (skill) => Chip(
                  label: Text(
                    skill,
                    style: theme.bodyStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: theme.ofWhiteColor,
                    ),
                  ),
                  backgroundColor: theme.chipColor,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
