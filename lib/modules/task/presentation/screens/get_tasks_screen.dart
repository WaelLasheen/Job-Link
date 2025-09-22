import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:job_link/modules/task/presentation/widgets/task_card.dart';

class GetTasksScreen extends StatelessWidget {
  const GetTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            List<Task> tasks = TaskCubit.get(context).tasks;
            if (tasks.isEmpty) {
              return const Center(
                child: Text('There is no tasks at current time'),
              );
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskCard(
                taskIndex: index,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouterStrings.taskDetails,
                    arguments: index,
                  );
                },
              ),
            );
          }
          if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
