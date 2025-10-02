import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/shared/services/alert_message.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/task/data/model/add_task_argus.dart';

class AcceptButton extends StatelessWidget {
  final String applicationId;
  final Job job;
  final Freelancer freelancer;

  const AcceptButton({
    super.key,
    required this.applicationId,
    required this.job,
    required this.freelancer,
  });

  @override
  Widget build(BuildContext context) {
    bool willRebuild = false;

    return BlocConsumer<JobApplicationCubit, JobApplicationState>(
      listener: (context, state) {
        if (state is JobApplicationSuccess && willRebuild) {
          alertMessage(context, 'Application accepted successfully');
          willRebuild = false;
        }
        if (state is JobApplicationFailure) {
          alertMessage(context, 'some thing went wrong: ${state.errMessage}');
          willRebuild = false;
        }
      },
      builder: (context, state) {
        if (state is JobApplicationLoading && willRebuild) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isAccepted =
            JobApplicationCubit.get(context).jobApplication!.status ==
            JobApplicationStatusEnum.accepted;

        return ElevatedButton(
          onPressed: () {
            if (isAccepted) {
              Navigator.of(context).pushNamed(
                RouterStrings.addTask,
                arguments: AddTaskArgus(
                  jobOwnerId: job.jobOwnerId,
                  jobOwnerName: job.jobOwnerCompanyName,
                  freelancerId: freelancer.id!,
                  freelancerName: freelancer.name,
                ),
              );
            } else {
              willRebuild = true;
              JobApplicationCubit.get(
                context,
              ).updateStatus(applicationId, JobApplicationStatusEnum.accepted);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            isAccepted ? 'Mention Task' : 'Accept',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
