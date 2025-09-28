import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/services/get_application_status_color.dart';

class StatusAndDateSection extends StatelessWidget {
  final JobApplicationStatusEnum status;
  final DateTime date;
  const StatusAndDateSection({super.key, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          label: Text(
            status.name,
            style: theme.labelStyle.copyWith(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: getJobApplicationStatusColor(status, context),
        ),
        Text("${date.toLocal()}".split(' ')[0], style: theme.hintStyle),
      ],
    );
  }
}
