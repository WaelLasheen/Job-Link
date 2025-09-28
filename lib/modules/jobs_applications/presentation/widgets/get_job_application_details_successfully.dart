import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/actions_button.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/freelancer_details_card.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_status.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_details_card.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/mention_task_button.dart';

class GetJobApplicationDetailsSuccessfully extends StatelessWidget {
  final JobApplication application;
  final Job job;
  final Freelancer freelancer;

  const GetJobApplicationDetailsSuccessfully({
    super.key,
    required this.application,
    required this.job,
    required this.freelancer,
  });

  @override
  Widget build(BuildContext context) {
    final bool isJobOwner =
        FirebaseAuthService().authState!.uid == job.jobOwnerId;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          const JobApplicationStatus(),
          FreelancerDetailsCard(freelancer: freelancer),
          JobDetailsCard(job: job),
          const SizedBox(height: 30),

          if (isJobOwner)
            ActionButtons(applicationId: application.applicationId!),

          if (isJobOwner) MentionTaskButton(job: job, freelancer: freelancer),
        ],
      ),
    );
  }
}
