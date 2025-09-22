import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/controller/filter_job_application_status_cubit/filter_job_application_by_status_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/filter_button.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_card.dart';

class SuccessUi extends StatelessWidget {
  final List<JobApplication> jobApplications;
  final bool isOnlyAccepted;
  const SuccessUi({
    super.key,
    required this.jobApplications,
    required this.isOnlyAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterJobApplicationByStatusCubit(jobApplications),
      child: Column(
        children: [
          if (!isOnlyAccepted)
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(JobApplicationStatusEnum.values.length, (
                    index,
                  ) {
                    return FilterButton(
                      status: JobApplicationStatusEnum.values[index],
                    );
                  }),
                ],
              ),
            ),

          Expanded(
            child: BlocBuilder<
              FilterJobApplicationByStatusCubit,
              JobApplicationStatusEnum
            >(
              builder: (context, state) {
                List<JobApplication> filteredJobApplications =
                    FilterJobApplicationByStatusCubit.get(context).filtered;
                if (filteredJobApplications.isEmpty) {
                  return const Center(child: Text('No jobs Application found.'));
                }
            
                return ListView.builder(
                  itemCount: filteredJobApplications.length,
                  itemBuilder: (context, index) {
                    final jobApplication = filteredJobApplications[index];
                    return JobApplicationCard(application: jobApplication);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
