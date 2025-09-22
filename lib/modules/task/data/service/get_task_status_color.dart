import 'package:flutter/material.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';

Color getTaskStatusColor(TaskStatusEnum status) {
  switch (status) {
    case TaskStatusEnum.notStarted:
      return Colors.grey;
    case TaskStatusEnum.inProgress:
      return Colors.blue;
    case TaskStatusEnum.completed:
      return Colors.green;
  }
}
