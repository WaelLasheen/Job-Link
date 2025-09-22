import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/jobs/controller/jobs_cubit/jobs_cubit.dart';
import 'package:job_link/modules/jobs/data/model/job_details_arguments.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs/presentation/widgets/job_card.dart';
import 'package:job_link/modules/jobs/presentation/widgets/splitter.dart';

class GetJobsScreen extends StatelessWidget {
  final MyAppUser user;
  const GetJobsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          List<Job> jobs = JobsCubit.get(context).jobs;
          if (state is JobsLoaded && jobs.isEmpty) {
            return const Center(child: Text('No jobs found.'));
          }
          if (state is JobsLoaded && jobs.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: jobs.length,
              separatorBuilder: (_, _) => Splitter(),
              itemBuilder: (context, index) {
                return JobCard(
                  job: jobs[index],
                  onTap: () => Navigator.of(context).pushNamed(
                    RouterStrings.jobDetails,
                    arguments: JobDetailsArguments(
                      job: jobs[index],
                      freelancer: user is Freelancer
                          ? user as Freelancer
                          : null,
                    ),
                  ),
                );
              },
            );
          }
          if (state is JobsError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
