import 'package:flutter/material.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/build_details_row.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/job_application_details_card.dart';

class JobDetailsCard extends StatelessWidget {
  final Job job;
  const JobDetailsCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return JobApplicationDetailsCard(
      title: 'Job Details',
      children: [
        BuildDetailsRow(label: 'Job', value: job.title),
        BuildDetailsRow(label: 'Company', value: job.jobOwnerCompanyName),
        BuildDetailsRow(
          label: 'Rate',
          value: '${job.paymentRate} ${job.paymentType.name}',
        ),
        BuildDetailsRow(label: 'Skills', value: job.requiredSkills.join(', ')),
        BuildDetailsRow(label: 'Description', value: job.description),
      ],
    );
  }
}
