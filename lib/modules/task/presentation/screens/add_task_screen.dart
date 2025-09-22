import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/services/alert_message.dart';
import 'package:job_link/core/shared/validation/validation_services.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/core/shared/widgets/app_text_field.dart';
import 'package:job_link/modules/task/controllers/date_cubit/date_cubit.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/model/add_task_argus.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:job_link/modules/task/presentation/widgets/pick_date.dart';
import 'package:job_link/modules/task/presentation/widgets/profile_header.dart';

class AddTaskScreen extends StatefulWidget {
  final AddTaskArgus argus;
  const AddTaskScreen({super.key, required this.argus});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                spacing: 20,
                children: [
                  const SizedBox(height: 5),
                  ProfileHeader(
                    name: widget.argus.freelancerName,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: 'Task Title',
                    prefixIcon: Icons.task,
                    controller: titleController,
                    validator: ValidationServices.validateRequiredField,
                  ),
                  AppTextField(
                    hint: 'Task Description',
                    prefixIcon: Icons.description,
                    controller: descriptionController,
                    validator: ValidationServices.validateRequiredField,
                  ),
                  const SizedBox(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PickDate(title: 'Starting Date', isStartingDate: true),
                      PickDate(title: 'Ending Date', isStartingDate: false),
                    ],
                  ),
                  const SizedBox(height: 25),

                  BlocConsumer<TaskCubit, TaskState>(
                    listener: (context, state) {
                      if (state is TaskLoaded) {
                        alertMessage(context, 'Task Created Successfully');
                        Navigator.pop(context);
                      }
                      if (state is TaskError) {
                        alertMessage(
                          context,
                          'some thing went wrong: ${state.message}',
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        text: state is TaskLoading ? 'Wait' : 'Save Task',
                        color: state is TaskLoading ? Colors.grey : Colors.blue,
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              state is! TaskLoading) {
                            Task task = Task(
                              jobOwnerId: widget.argus.jobOwnerId,
                              jobOwnerName: widget.argus.jobOwnerName,
                              freelancerId: widget.argus.freelancerId,
                              freelancerName: widget.argus.freelancerName,
                              taskTitle: titleController.text,
                              taskDescription: descriptionController.text,
                              startDate: DateCubit.get(context).startingDate,
                              endDate: DateCubit.get(context).endingDate,
                              createdAt: DateTime.now(),
                            );
                            TaskCubit.get(context).addTask(task);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
