import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';

Color getJobApplicationStatusColor(JobApplicationStatusEnum status , BuildContext context) {
      final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

  switch (status) {
    case JobApplicationStatusEnum.pending:
      return theme.jobApplicationPendingColor;
    case JobApplicationStatusEnum.accepted:
      return theme.jobApplicationAcceptedColor;

    case JobApplicationStatusEnum.rejected:
      return theme.jobApplicationRejectedColor;

    case JobApplicationStatusEnum.all:
      return theme.jobApplicationAllColor;

  }
}
