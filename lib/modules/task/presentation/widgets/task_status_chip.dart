import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/service/get_task_status_color.dart';

class TaskStatusChip extends StatelessWidget {
  final int taskIndex;
  final double fontSize;
  const TaskStatusChip({
    super.key,
    required this.taskIndex,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final TaskStatusEnum taskStatus = TaskCubit.get(
          context,
        ).tasks[taskIndex].status;
        return Align(
          alignment: Alignment.centerRight,
          child: Chip(
            backgroundColor: getTaskStatusColor(
              taskStatus,
            ),
            label: Text(
              taskStatus.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
