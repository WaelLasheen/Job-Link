import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/services/get_application_status_color.dart';

class JobApplicationStatus extends StatelessWidget {
  const JobApplicationStatus({super.key});

  @override
  Widget build(BuildContext context) {
        final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return BlocBuilder<JobApplicationCubit, JobApplicationState>(
      builder: (context, state) {
        if (state is JobApplicationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        JobApplicationStatusEnum status = JobApplicationCubit.get(
          context,
        ).jobApplication!.status;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: getJobApplicationStatusColor(status,context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: getJobApplicationStatusColor(status,context),
              width: 1,
            ),
          ),
          child: Text(
            'Status: ${status.name.toUpperCase()}',
            textAlign: TextAlign.center,
            style: theme.labelStyle.copyWith(
              color: Colors.white
            ),
          ),
        );
      },
    );
  }
}
