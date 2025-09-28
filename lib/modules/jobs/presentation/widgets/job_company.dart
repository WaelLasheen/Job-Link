import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobCompany extends StatelessWidget {
  final Job job;
  const JobCompany({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      children: [
        Icon(Icons.business, size: 20, color: theme.grey),
        const SizedBox(width: 6),
        Text(job.jobOwnerCompanyName, style: theme.bodyStyle),
      ],
    );
  }
}
