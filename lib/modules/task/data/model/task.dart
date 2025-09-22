import 'package:hive/hive.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
part 'task.g.dart';


@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String? taskId;
  @HiveField(1)
  final String jobOwnerId;
  @HiveField(2)
  final String jobOwnerName;
  @HiveField(3)
  final String freelancerId;
  @HiveField(4)
  final String freelancerName;
  @HiveField(5)
  final String taskTitle;
  @HiveField(6)
  final String taskDescription;
  @HiveField(7)
  final DateTime startDate;
  @HiveField(8)
  final DateTime endDate;
  @HiveField(9)
  TaskStatusEnum status;
  @HiveField(10)
  final DateTime createdAt;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  Task({
    this.taskId,
    required this.jobOwnerId,
    required this.freelancerId,
    required this.freelancerName,
    required this.jobOwnerName,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDate,
    required this.endDate,
    this.status = TaskStatusEnum.notStarted,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      taskId: json[_firebaseStrings.taskId],
      jobOwnerId: json[_firebaseStrings.jobOwnerId],
      jobOwnerName: json[_firebaseStrings.jobOwnerName],
      freelancerId: json[_firebaseStrings.freelancerId],
      freelancerName: json[_firebaseStrings.freelancerName],
      taskTitle: json[_firebaseStrings.taskTitle],
      taskDescription: json[_firebaseStrings.taskDescription],
      startDate: DateTime.parse(json[_firebaseStrings.startDate]),
      endDate: DateTime.parse(json[_firebaseStrings.endDate]),
      status: TaskStatusEnum.values.firstWhere(
        (e) => e.name == json[_firebaseStrings.taskStatue],
      ),
      createdAt: DateTime.parse(json[_firebaseStrings.createdAt]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _firebaseStrings.taskId: taskId,
      _firebaseStrings.jobOwnerId: jobOwnerId,
      _firebaseStrings.jobOwnerName: jobOwnerName,
      _firebaseStrings.freelancerId: freelancerId,
      _firebaseStrings.freelancerName: freelancerName,
      _firebaseStrings.taskTitle: taskTitle,
      _firebaseStrings.taskDescription: taskDescription,
      _firebaseStrings.startDate: startDate.toIso8601String(),
      _firebaseStrings.endDate: endDate.toIso8601String(),
      _firebaseStrings.taskStatue: status.toString().split('.').last,
      _firebaseStrings.createdAt: createdAt.toIso8601String(),
    };
  }

  Task copyWith({String? taskId}) {
    return Task(
      taskId: taskId ?? this.taskId,
      jobOwnerId: jobOwnerId,
      freelancerId: freelancerId,
      freelancerName: freelancerName,
      jobOwnerName: jobOwnerName,
      taskTitle: taskTitle,
      taskDescription: taskDescription,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
    );
  }
}
