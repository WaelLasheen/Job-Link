import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_details_cubit/job_application_details_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/get_job_application_details_successfully.dart';

class JobApplicationDetailsScreen extends StatefulWidget {
  final JobApplication application;
  const JobApplicationDetailsScreen({super.key, required this.application});

  @override
  State<JobApplicationDetailsScreen> createState() =>
      _JobApplicationDetailsScreenState();
}

class _JobApplicationDetailsScreenState
    extends State<JobApplicationDetailsScreen> {

  @override
  void initState() {
    super.initState();
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
            return GetJobApplicationDetailsSuccessfully(
              application: widget.application,
              job: state.jobDetails,
              freelancer: state.freelancerDetails,
            );
          }
          if (state is JobApplicationDetailsFailure) {
            return Center(child: Text(state.errMessage));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}