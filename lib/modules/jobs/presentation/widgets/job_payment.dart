import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobPayment extends StatelessWidget {
  final Job job;
  const JobPayment({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      children: [
        Icon(Icons.monetization_on, color: Colors.green.shade600, size: 20),
        const SizedBox(width: 8),
        Text(
          '\$${job.paymentRate}/${job.paymentType.toString().split('.').last}',
          style: theme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
