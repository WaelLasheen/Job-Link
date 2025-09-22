import 'package:flutter/material.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';

class JobApplicationCard extends StatelessWidget {
  final JobApplication application;

  const JobApplicationCard({super.key, required this.application});

  Color getChipColor(JobApplicationStatusEnum status) {
    switch (status) {
      case JobApplicationStatusEnum.pending:
        return Colors.grey.shade300;
      case JobApplicationStatusEnum.accepted:
        return Colors.green.shade300;
      case JobApplicationStatusEnum.rejected:
        return Colors.red.shade300;
      case JobApplicationStatusEnum.all:
        return Colors.blue.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouterStrings.jobApplicationDetails,
          arguments: application,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [jobTitle(context), freelancerName(), statusAndDate()],
          ),
        ),
      ),
    );
  }

  Widget jobTitle(BuildContext context) {
    return Text(
      application.jobTitle,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget freelancerName() {
    return Row(
      children: [
        const Icon(Icons.person, size: 18, color: Colors.grey),
        const SizedBox(width: 6),
        Text(application.freelancerName),
      ],
    );
  }

  Widget statusAndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          label: Text(application.status.name),
          backgroundColor: getChipColor(application.status),
        ),
        Text(
          "${application.appliedAt.toLocal()}".split(' ')[0],
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
