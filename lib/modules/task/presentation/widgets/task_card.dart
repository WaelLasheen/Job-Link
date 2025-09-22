import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:job_link/modules/task/presentation/widgets/date_chip.dart';
import 'package:job_link/modules/task/presentation/widgets/profile_header.dart';
import 'package:job_link/modules/task/presentation/widgets/task_status_chip.dart';

class TaskCard extends StatelessWidget {
  final int taskIndex;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.onTap, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    Task task = TaskCubit.get(context).tasks[taskIndex];
    bool isFreelancer =
        task.freelancerId == FirebaseAuthService().authState!.uid;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Text(
                      task.taskTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TaskStatusChip(taskIndex: taskIndex, fontSize: 18),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileHeader(
                    name: isFreelancer
                        ? 'From: ${task.jobOwnerName}'
                        : 'To: ${task.freelancerName}',
                    icon: isFreelancer ? Icons.business : Icons.person,
                    radius: 14,
                    fontSize: 18,
                  ),
                  DateChip(date: task.endDate, fontSize: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
