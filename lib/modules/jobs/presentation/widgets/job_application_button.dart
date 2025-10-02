import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';

class JobApplicationButton extends StatelessWidget {
  final Job job;
  final Freelancer freelancer;

  const JobApplicationButton({
    super.key,
    required this.job,
    required this.freelancer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobApplicationCubit, JobApplicationState>(
      listener: (context, state) {
        if (state is JobApplicationSuccess) {
          bool isApplied =
              JobApplicationCubit.get(context).jobApplication != null;
          String text = isApplied ? 'applied' : 'cancelled';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Job $text successfully')),
          );
        }
        if (state is JobApplicationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        JobApplication? jobApplication = JobApplicationCubit.get(
          context,
        ).jobApplication;
        bool isApplied = jobApplication != null;
        late String text;
        if (!isApplied) {
          text = 'apply';
        } else if (jobApplication.status == JobApplicationStatusEnum.accepted) {
          text = 'Resign';
        } else {
          text = 'cancel';
        }

        return AppButton(
          text: state is JobApplicationLoading ? 'wait' : text,
          onPressed: () {
            if (state is JobApplicationLoading) return;

            if (isApplied) {
              JobApplicationCubit.get(context).cancelJobApplication();
            } else {
              jobApplication = JobApplication(
                jobId: job.jobId!,
                jobTitle: job.title,
                jobOwnerId: job.jobOwnerId,
                freelancerId: freelancer.id!,
                freelancerName: freelancer.name,
                appliedAt: DateTime.now(),
              );
              JobApplicationCubit.get(
                context,
              ).applyAtJobApplication(jobApplication!);
            }
          },
        );
      },
    );
  }
}
