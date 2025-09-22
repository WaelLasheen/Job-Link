import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:job_link/modules/task/presentation/widgets/date_range_row.dart';
import 'package:job_link/modules/task/presentation/widgets/profile_header.dart';
import 'package:job_link/modules/task/presentation/widgets/task_status_button.dart';
import 'package:job_link/modules/task/presentation/widgets/task_status_chip.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskIndex;

  const TaskDetailsScreen({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    final Task task = TaskCubit.get(context).tasks[taskIndex];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              ProfileHeader(name: task.freelancerName, icon: Icons.person),
              const SizedBox(height: 8),
              Text(
                task.taskTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                task.taskDescription,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DateRangeRow(startDate: task.startDate, endDate: task.endDate),
              const SizedBox(height: 16),
              TaskStatusChip(taskIndex: taskIndex),
              const SizedBox(height: 16),
              ProfileHeader(name: task.jobOwnerName, icon: Icons.business),
              const SizedBox(height: 50),
              if(FirebaseAuthService().authState!.uid == task.freelancerId)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskStatusButton(
                    taskId: task.taskId!,
                    status: TaskStatusEnum.completed,
                  ),
                  TaskStatusButton(
                    taskId: task.taskId!,
                    status: TaskStatusEnum.inProgress,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
