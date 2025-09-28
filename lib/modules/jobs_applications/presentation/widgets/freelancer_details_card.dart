import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/build_details_row.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_details_card.dart';

class FreelancerDetailsCard extends StatelessWidget {
  final Freelancer freelancer;
  const FreelancerDetailsCard({super.key, required this.freelancer});

  @override
  Widget build(BuildContext context) {
    return JobApplicationDetailsCard(
      title: 'Applicant Details',
      children: [
        BuildDetailsRow(label: 'Name', value: freelancer.name),
        BuildDetailsRow(label: 'Title', value: freelancer.jobTitle),
        BuildDetailsRow(label: 'Experience', value: freelancer.experience),
        BuildDetailsRow(label: 'CV', value: freelancer.cvUrl ?? ''),
      ],
    );
  }
}