import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobTitle extends StatelessWidget {
  final Job job;
  const JobTitle({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return Text(job.title, style: theme.titleStyle);
  }
}
