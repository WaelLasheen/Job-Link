import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/get_jobs_applications_successfully.dart';

class GetJobsApplicationsScreen extends StatelessWidget {
  final bool isOnlyAccepted;
  const GetJobsApplicationsScreen({super.key, this.isOnlyAccepted = false});

  List<JobApplication> getOnlyAccepted(List<JobApplication> jobApplications) {
    return jobApplications
        .where(
          (jobApplication) =>
              jobApplication.status == JobApplicationStatusEnum.accepted,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<JobApplicationCubit, JobApplicationState>(
        builder: (context, state) {
          if (state is JobApplicationSuccess) {
            List<JobApplication> jobApplications = JobApplicationCubit.get(
              context,
            ).jobApplications;
            if (isOnlyAccepted) {
              jobApplications = getOnlyAccepted(jobApplications);
            }
            if (jobApplications.isEmpty) {
              return const Center(child: Text('No jobs Application found.'));
            } else {
              return GetJobsApplicationsSuccessfully(
                jobApplications: jobApplications,
                isOnlyAccepted: isOnlyAccepted,
              );
            }
          }

          if (state is JobApplicationFailure) {
            return Center(child: Text(state.errMessage));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
