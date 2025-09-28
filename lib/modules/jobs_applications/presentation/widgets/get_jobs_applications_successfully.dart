import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/controller/filter_job_application_status_cubit/filter_job_application_by_status_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/applications_list.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/filter_section.dart';

class GetJobsApplicationsSuccessfully extends StatelessWidget {
  final List<JobApplication> jobApplications;
  final bool isOnlyAccepted;

  const GetJobsApplicationsSuccessfully({
    super.key,
    required this.jobApplications,
    required this.isOnlyAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterJobApplicationByStatusCubit(jobApplications),
      child: Column(
        children: [
          if (!isOnlyAccepted) const FilterSection(),
          const Expanded(child: ApplicationsList()),
        ],
      ),
    );
  }
}
