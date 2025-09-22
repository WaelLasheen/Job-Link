import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:job_link/modules/task/data/service/task_firestore_service.dart';
import 'package:job_link/modules/task/data/service/task_hive_service.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskFirestoreService taskFirebaseService;
  final TaskHiveService taskHiveService;
  TaskCubit(this.taskFirebaseService, this.taskHiveService)
    : super(TaskInitial());
  List<Task> tasks = [];

  void addTask(Task task) {
    emit(TaskLoading());
    taskFirebaseService
        .addTask(task)
        .then((newTask) {
          tasks.add(newTask);
          emit(TaskLoaded(tasks));
          taskHiveService.cacheTasks(tasks).catchError((error) {
            throw 'error in caching tasks $error';
          });
        })
        .catchError((error) {
          emit(TaskError(error.toString()));
        });
  }

  void getFreelancerTasks(String freelancerId) {
    emit(TaskLoading());
    taskFirebaseService
        .getFreelancerTasks(freelancerId)
        .then((newTasks) {
          tasks = newTasks;
          emit(TaskLoaded(tasks));
          taskHiveService.cacheTasks(tasks).catchError((error) {
            throw 'error in caching tasks $error';
          });
        })
        .catchError((error) {
          emit(TaskError(error.toString()));
        });
  }

  void getJobOwnerTasks(String jobOwnerId) {
    emit(TaskLoading());
    taskFirebaseService
        .getJobOwnerTasks(jobOwnerId)
        .then((newTasks) {
          tasks = newTasks;
          emit(TaskLoaded(tasks));
          taskHiveService.cacheTasks(tasks).catchError((error) {
            throw 'error in caching tasks $error';
          });
        })
        .catchError((error) {
          emit(TaskError(error.toString()));
        });
  }

  void getTasksOffline() {
    emit(TaskLoading());
    taskHiveService
        .getCachedTasks()
        .then((cachedTasks) {
          tasks = cachedTasks;
          emit(TaskLoaded(tasks));
        })
        .catchError((error) {
          emit(TaskError("Error in getting offline tasks: $error"));
        });
  }

  void changeTaskStatus(String taskId, TaskStatusEnum newStatus) {
    emit(TaskLoading());
    taskFirebaseService
        .changeTaskStatus(taskId, newStatus)
        .then((_) {
          final taskIndex = tasks.indexWhere((task) => task.taskId == taskId);
          tasks[taskIndex].status = newStatus;
          emit(TaskLoaded(tasks));
        })
        .catchError((error) {
          emit(TaskError(error.toString()));
        });
  }

  // void editTask(Task updatedTask) {
  //   emit(TaskLoading());
  //   taskService
  //       .editTask(updatedTask)
  //       .then((_) {
  //         final taskIndex = tasks.indexWhere(
  //           (task) => task.taskId == updatedTask.taskId,
  //         );
  //         tasks[taskIndex] = updatedTask;
  //         emit(TaskLoaded(tasks));
  //       })
  //       .catchError((error) {
  //         emit(TaskError(error.toString()));
  //       });
  // }

  static TaskCubit get(context) => BlocProvider.of(context);
}
