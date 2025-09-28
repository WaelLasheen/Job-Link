import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs_applications/controller/filter_job_application_status_cubit/filter_job_application_by_status_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/services/get_application_status_color.dart';

class FilterButton extends StatelessWidget {
  final JobApplicationStatusEnum status;
  const FilterButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return InkWell(
      onTap: () {
        FilterJobApplicationByStatusCubit.get(
          context,
        ).filterJobApplication(status);
      },
      child: Chip(
        backgroundColor: getJobApplicationStatusColor(status, context),
        label: Text(
          status.name,
          style: theme.labelStyle.copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
