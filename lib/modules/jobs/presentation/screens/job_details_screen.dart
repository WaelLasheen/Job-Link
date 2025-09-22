import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/modules/jobs/data/model/job_details_arguments.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobDetailsArguments arguments;

  const JobDetailsScreen({super.key, required this.arguments});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job job;
  Freelancer? freelancer;

  @override
  void initState() {
    super.initState();
    job = widget.arguments.job;
    freelancer = widget.arguments.freelancer;

    if (freelancer != null) {
      JobApplicationCubit.get(context).appliedBefore(
        freelanceID: widget.arguments.freelancer!.id!,
        jobID: job.jobId!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                job.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Company
              Row(
                children: [
                  const Icon(Icons.business, size: 20, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    job.jobOwnerCompanyName,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Description
              Text(
                "Job Description",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(job.description),
              const SizedBox(height: 20),
              // Payment Details
              Row(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.green.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${job.paymentRate}/${job.paymentType.toString().split('.').last}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Required Skills
              Text(
                "Required Skills",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: job.requiredSkills
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        backgroundColor: Colors.blue.shade50,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 50),
              if (widget.arguments.freelancer != null)
                BlocConsumer<JobApplicationCubit, JobApplicationState>(
                  listener: (context, state) {
                    if (state is JobApplicationSuccess) {
                      bool isApplied =
                          JobApplicationCubit.get(context).jobApplication !=
                          null;
                      String text = isApplied ? 'applied' : 'cancelled';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Job $text successfully')),
                      );
                    }
                    if (state is JobApplicationFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                    }
                  },
                  builder: (context, state) {
                    JobApplication? jobApplication = JobApplicationCubit.get(
                      context,
                    ).jobApplication;
                    bool isApplied = jobApplication != null;
                    String text = isApplied ? 'cancel' : 'apply';
                    return AppButton(
                      text: state is JobApplicationLoading ? 'wait' : text,
                      onPressed: () {
                        if (state is JobApplicationLoading) return;
                        if (isApplied) {
                          JobApplicationCubit.get(
                            context,
                          ).cancelJobApplication();
                        } else {
                          jobApplication = JobApplication(
                            jobId: job.jobId!,
                            jobTitle: job.title,
                            jobOwnerId: job.jobOwnerId,
                            freelancerId: freelancer!.id!,
                            freelancerName: freelancer!.name,
                            appliedAt: DateTime.now(),
                          );

                          JobApplicationCubit.get(
                            context,
                          ).applyAtJobApplication(jobApplication!);
                        }
                      },
                      color: Colors.blue.shade300,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
