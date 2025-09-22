import 'package:hive/hive.dart';
import 'package:job_link/modules/task/data/model/task.dart';

class TaskHiveService {
  static const String boxName = "tasksBox";

  Future<Box<Task>> _openBox() async {
    return await Hive.openBox<Task>(boxName);
  }

  Future<void> cacheTasks(List<Task> tasks) async {
    final box = await _openBox();
    await box.clear();
    for (var task in tasks) {
      await box.put(task.taskId, task);
    }
  }

  Future<List<Task>> getCachedTasks() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> clearCache() async {
    final box = await _openBox();
    await box.clear();
  }
}
