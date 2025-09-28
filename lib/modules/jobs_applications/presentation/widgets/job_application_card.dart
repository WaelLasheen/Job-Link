import 'package:flutter/material.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_info_section.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/status_and_date_section.dart';

class JobApplicationCard extends StatelessWidget {
  final JobApplication application;

  const JobApplicationCard({super.key, required this.application});

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
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobInfoSection(
                title: application.jobTitle,
                freelancerName: application.freelancerName,
              ),
              StatusAndDateSection(
                status: application.status,
                date: application.appliedAt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
