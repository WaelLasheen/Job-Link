import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/accept_button.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/reject_button.dart';

class ActionButtons extends StatelessWidget {
  final String applicationId;
  final Job job;
  final Freelancer freelancer;
  
  const ActionButtons({
    super.key,
    required this.applicationId,
    required this.job,
    required this.freelancer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: RejectButton(applicationId: applicationId)),
          Expanded(
            child: AcceptButton(
              applicationId: applicationId,
              job: job,
              freelancer: freelancer,
            ),
          ),
        ],
      ),
    );
  }
}
