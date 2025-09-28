import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/controller/filter_job_application_status_cubit/filter_job_application_by_status_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_card.dart';

class ApplicationsList extends StatelessWidget {
  const ApplicationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FilterJobApplicationByStatusCubit,
      JobApplicationStatusEnum
    >(
      builder: (context, state) {
        final filtered = FilterJobApplicationByStatusCubit.get(
          context,
        ).filtered;

        if (filtered.isEmpty) {
          return const Center(child: Text('No jobs Application found.'));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final jobApplication = filtered[index];
            return JobApplicationCard(application: jobApplication);
          },
        );
      },
    );
  }
}
