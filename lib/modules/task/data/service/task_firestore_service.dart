import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/model/task.dart';

class TaskFirestoreService {
  static final TaskFirestoreService _instance =
      TaskFirestoreService._internal();
  factory TaskFirestoreService() => _instance;
  TaskFirestoreService._internal();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  Future<Task> addTask(Task task) async {
    try {
      final docRef = _firestore
          .collection(_firebaseStrings.tasksCollection)
          .doc();
      task = task.copyWith(taskId: docRef.id);
      await docRef.set(task.toMap());
      return task;
    } catch (e) {
      throw 'Error in addTask: $e';
    }
  }

  Future<List<Task>> getFreelancerTasks(String freelancerId) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.tasksCollection)
          .where(_firebaseStrings.freelancerId, isEqualTo: freelancerId)
          .get();

      return doc.docs.map((doc) => Task.fromMap(doc.data())).toList();
    } catch (e) {
      throw 'Error in getFreelancerTasks: $e';
    }
  }

  Future<List<Task>> getJobOwnerTasks(String jobOwnerId) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.tasksCollection)
          .where(_firebaseStrings.jobOwnerId, isEqualTo: jobOwnerId)
          .get();

      return doc.docs.map((doc) => Task.fromMap(doc.data())).toList();
    } catch (e) {
      throw 'Error in getFreelancerTasks: $e';
    }
  }

  Future<void> changeTaskStatus(String taskId, TaskStatusEnum newStatus) async {
    try {
      await _firestore
          .collection(_firebaseStrings.tasksCollection)
          .doc(taskId)
          .update({_firebaseStrings.taskStatue: newStatus.name});
    } catch (e) {
      throw 'Error in changeTaskStatus: $e';
    }
  }

  Future<void> editTask(Task updatedTask) async {
    try {
      await _firestore
          .collection(_firebaseStrings.tasksCollection)
          .doc(updatedTask.taskId)
          .update(updatedTask.toMap());
    } catch (e) {
      throw 'Error in editTask: $e';
    }
  }
}
