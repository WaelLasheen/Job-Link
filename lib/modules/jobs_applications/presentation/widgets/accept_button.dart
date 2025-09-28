import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/services/alert_message.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';

class AcceptButton extends StatelessWidget {
  final String applicationId;
  const AcceptButton({super.key, required this.applicationId});

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
        
        return ElevatedButton(
          onPressed: () {
            willRebuild = true;
            JobApplicationCubit.get(context).updateStatus(
              applicationId,
              JobApplicationStatusEnum.accepted,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Accept',
            style: TextStyle(
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
