import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/services/alert_message.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/service/get_task_status_color.dart';

class TaskStatusButton extends StatelessWidget {
  final String taskId;
  final TaskStatusEnum status;
  const TaskStatusButton({
    super.key,
    required this.taskId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool change = false;
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskError && change) {
          alertMessage(context, 'some thing went wrong: ${state.message}');
          change = false;
        }
        if (state is TaskLoaded && change) {
          alertMessage(context, 'Task Status Changed Successfully');
          change = false;
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (state is! TaskLoading) {
              change = true;
              TaskCubit.get(context).changeTaskStatus(
                taskId,
                status,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: getTaskStatusColor(
              status,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          child: Text(
            state is TaskLoading && change ? 'Wait' : status.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 28,
            ),
          ),
        );
      },
    );
  }
}
