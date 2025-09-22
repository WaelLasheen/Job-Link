import 'package:hive/hive.dart';
part 'task_state_enum.g.dart';

@HiveType(typeId: 0)
enum TaskStatusEnum {
  @HiveField(0)
  notStarted,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed,
}
