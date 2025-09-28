import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobDescription extends StatelessWidget {
  final Job job;
  const JobDescription({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Job Description", style: theme.subtitleStyle),
        const SizedBox(height: 8),
        Text(
          job.description,
          style: theme.bodyStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.descriptionColor,
          ),
        ),
      ],
    );
  }
}
