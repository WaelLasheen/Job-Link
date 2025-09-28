import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_details_arguments.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_application_button.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_payment.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_company.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_description.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_skills.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_title.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';

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
        freelanceID: freelancer!.id!,
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
            spacing: 12,
            children: [
              JobTitle(job: job),
              JobCompany(job: job),
              const SizedBox(height: 8),
              JobDescription(job: job),
              const SizedBox(height: 8),
              JobPayment(job: job),
              const SizedBox(height: 8),
              JobSkills(job: job),
              const SizedBox(height: 50),
              if (freelancer != null)
                JobApplicationButton(job: job, freelancer: freelancer!),
            ],
          ),
        ),
      ),
    );
  }
}
