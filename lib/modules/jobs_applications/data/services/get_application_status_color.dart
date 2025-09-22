import 'package:flutter/material.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';

Color getJobApplicationStatusColor(JobApplicationStatusEnum status) {
  switch (status) {
    case JobApplicationStatusEnum.pending:
      return Colors.grey;
    case JobApplicationStatusEnum.accepted:
      return Colors.green.shade300;
    case JobApplicationStatusEnum.rejected:
      return Colors.red.shade300;
    case JobApplicationStatusEnum.all:
      return Colors.blue.shade300;
  }
}
