//  import 'package:flutter/material.dart';
// import 'package:job_link/modules/jobs/controller/jobs_cubit/jobs_cubit.dart';
// import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';

// void initializationCubits(BuildContext context) {
//     final JobsCubit jobCubit = JobsCubit.get(context);
//     final JobApplicationCubit jobApplicationCubit = JobApplicationCubit.get(
//       context,
//     );
//     if (isFreelancer) {
//       jobCubit.getAllJobs();
//       jobApplicationCubit.getJobApplicationsForFreelancer(widget.user.id!);
//     } else {
//       jobCubit.getJobOwnerJobs(widget.user.id!);
//       jobApplicationCubit.getJobApplicationsForJobOwner(widget.user.id!);
//     }
//   }