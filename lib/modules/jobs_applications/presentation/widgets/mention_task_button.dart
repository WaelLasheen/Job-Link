import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/task/data/model/add_task_argus.dart';

class MentionTaskButton extends StatelessWidget {
  final Job job;
  final Freelancer freelancer;

  const MentionTaskButton({
    super.key,
    required this.job,
    required this.freelancer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobApplicationCubit, JobApplicationState>(
      builder: (context, state) {
        bool isAccepted =
            JobApplicationCubit.get(context).jobApplication!.status ==
            JobApplicationStatusEnum.accepted;
        if (isAccepted && state is JobApplicationSuccess) {
          return AppButton(
            text: 'Mention Task',
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouterStrings.addTask,
                arguments: AddTaskArgus(
                  jobOwnerId: job.jobOwnerId,
                  jobOwnerName: job.jobOwnerCompanyName,
                  freelancerId: freelancer.id!,
                  freelancerName: freelancer.name,
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
