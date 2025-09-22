import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_details_cubit/job_application_details_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/build_details_row.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_details_card.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_status.dart';
import 'package:job_link/modules/task/data/model/add_task_argus.dart';

class JobApplicationDetailsScreen extends StatefulWidget {
  final JobApplication application;
  const JobApplicationDetailsScreen({super.key, required this.application});

  @override
  State<JobApplicationDetailsScreen> createState() =>
      _JobApplicationDetailsScreenState();
}

class _JobApplicationDetailsScreenState
    extends State<JobApplicationDetailsScreen> {
  late bool willAccept;
  @override
  void initState() {
    super.initState();
    willAccept = widget.application.status != JobApplicationStatusEnum.rejected;
    JobApplicationCubit.get(context).jobApplication = widget.application;

    JobApplicationDetailsCubit.get(context).getJobApplicationDetails(
      userId: widget.application.freelancerId,
      jobId: widget.application.jobId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Application Details"),
        centerTitle: true,
      ),
      body: BlocBuilder<JobApplicationDetailsCubit, JobApplicationDetailsState>(
        builder: (context, state) {
          if (state is JobApplicationDetailsSuccess) {
            final Job job = state.jobDetails;
            final Freelancer freelancer = state.freelancerDetails;
            return successUI(freelancer, job);
          }
          if (state is JobApplicationDetailsFailure) {
            return Center(child: Text(state.errMessage));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget successUI(Freelancer freelancer, Job job) {
    bool isJobOwner = FirebaseAuthService().authState!.uid == job.jobOwnerId;
    var children = [
      const JobApplicationStatus(),
      const SizedBox(height: 20),
      freelancerDetailsCard(freelancer: freelancer),
      const SizedBox(height: 16),
      jobDetailsCard(job: job),

      const SizedBox(height: 50),
      if (isJobOwner)
        buttons(
          onAccept: () {
            willAccept = true;
            JobApplicationCubit.get(context).updateStatus(
              widget.application.applicationId!,
              JobApplicationStatusEnum.accepted,
            );
          },
          onReject: () {
            willAccept = false;
            JobApplicationCubit.get(context).updateStatus(
              widget.application.applicationId!,
              JobApplicationStatusEnum.rejected,
            );
          },
        ),
      const SizedBox(height: 20),
      if (isJobOwner &&
          JobApplicationCubit.get(
                context,
              ).jobApplication!.status ==
              JobApplicationStatusEnum.accepted)
        BlocBuilder<JobApplicationCubit, JobApplicationState>(
          builder: (context, state) {
            if (state is JobApplicationSuccess) {
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
        ),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget freelancerDetailsCard({required Freelancer freelancer}) {
    return JobApplicationDetailsCard(
      title: 'Applicant Details',
      children: [
        BuildDetailsRow(label: 'Name', value: freelancer.name),
        BuildDetailsRow(label: 'Title', value: freelancer.jobTitle),
        BuildDetailsRow(label: 'Experience', value: freelancer.experience),
        BuildDetailsRow(label: 'CV', value: freelancer.cvUrl!),
      ],
    );
  }

  Widget jobDetailsCard({required Job job}) {
    return JobApplicationDetailsCard(
      title: 'Job Details',
      children: [
        BuildDetailsRow(label: 'Job', value: job.title),
        BuildDetailsRow(label: 'Company', value: job.jobOwnerCompanyName),
        BuildDetailsRow(
          label: 'Rate',
          value: '${job.paymentRate} ${job.paymentType.name}',
        ),
        BuildDetailsRow(label: 'Skills', value: job.requiredSkills.join(', ')),
        BuildDetailsRow(label: 'Description', value: job.description),
      ],
    );
  }

  Widget buttons({
    required VoidCallback onAccept,
    required VoidCallback onReject,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: BlocConsumer<JobApplicationCubit, JobApplicationState>(
              listener: (context, state) {
                if (state is JobApplicationSuccess && !willAccept) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application rejected successfully'),
                    ),
                  );
                }
                if (state is JobApplicationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'some thing went wrong: ${state.errMessage}',
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is JobApplicationLoading && !willAccept) {
                  return const Center(child: CircularProgressIndicator());
                }

                return OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    // backgroundColor: Colors.transparent,
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
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlocConsumer<JobApplicationCubit, JobApplicationState>(
              listener: (context, state) {
                if (state is JobApplicationSuccess && willAccept) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application accepted successfully'),
                    ),
                  );
                }
                if (state is JobApplicationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'some thing went wrong: ${state.errMessage}',
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is JobApplicationLoading && willAccept) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: onAccept,
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
            ),
          ),
        ],
      ),
    );
  }
}
