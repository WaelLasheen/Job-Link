import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs/data/enum/payment_type_enum.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    Color chipColor = job.paymentType == PaymentTypeEnum.perHour
        ? Colors.green.shade300
        : Colors.orange.shade300;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: title(context, chipColor),
            subtitle: Text(
              job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.bodyStyle.copyWith(color: theme.descriptionColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget title(BuildContext context, Color chipColor) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return Row(
      spacing: 4,
      children: [
        Expanded(
          child: Text(
            job.title,
            style: theme.titleStyle.copyWith(fontSize: 25),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Chip(
          label: Text(
            job.paymentType.name,
            style: theme.bodyStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.ofWhiteColor,
            ),
          ),
          backgroundColor: chipColor,
        ),
      ],
    );
  }
}
