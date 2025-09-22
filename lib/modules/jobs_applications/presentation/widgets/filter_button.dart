import 'package:flutter/material.dart';
import 'package:job_link/modules/jobs_applications/controller/filter_job_application_status_cubit/filter_job_application_by_status_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/services/get_application_status_color.dart';

class FilterButton extends StatelessWidget {
  final JobApplicationStatusEnum status;
  const FilterButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FilterJobApplicationByStatusCubit.get(
          context,
        ).filterJobApplication(status);
      },
      child: Chip(
        backgroundColor: getJobApplicationStatusColor(status),
        label: Text(
          status.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
