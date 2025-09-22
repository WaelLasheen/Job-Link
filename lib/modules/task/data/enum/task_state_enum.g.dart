// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskStatusEnumAdapter extends TypeAdapter<TaskStatusEnum> {
  @override
  final int typeId = 0;

  @override
  TaskStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatusEnum.notStarted;
      case 1:
        return TaskStatusEnum.inProgress;
      case 2:
        return TaskStatusEnum.completed;
      default:
        return TaskStatusEnum.notStarted;
    }
  }

  @override
  void write(BinaryWriter writer, TaskStatusEnum obj) {
    switch (obj) {
      case TaskStatusEnum.notStarted:
        writer.writeByte(0);
        break;
      case TaskStatusEnum.inProgress:
        writer.writeByte(1);
        break;
      case TaskStatusEnum.completed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
