import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/services/alert_message.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';

class RejectButton extends StatelessWidget {
  final String applicationId;
  const RejectButton({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context) {
    bool willRebuild = false;
    return BlocConsumer<JobApplicationCubit, JobApplicationState>(
      listener: (context, state) {
        if (state is JobApplicationSuccess && willRebuild) {
          alertMessage(context, 'Application rejected successfully');
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

        return OutlinedButton(
          onPressed: () {
            willRebuild = true;
            JobApplicationCubit.get(context).updateStatus(
              applicationId,
              JobApplicationStatusEnum.rejected,
            );
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Reject',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
