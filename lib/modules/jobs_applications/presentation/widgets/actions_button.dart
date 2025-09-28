import 'package:flutter/material.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/accept_button.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/reject_button.dart';

class ActionButtons extends StatelessWidget {
  final String applicationId;

  const ActionButtons({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(child: RejectButton(applicationId: applicationId)),
          Expanded(child: AcceptButton(applicationId: applicationId)),
        ],
      ),
    );
  }
}
