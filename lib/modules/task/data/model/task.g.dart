// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 1;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      taskId: fields[0] as String?,
      jobOwnerId: fields[1] as String,
      freelancerId: fields[3] as String,
      freelancerName: fields[4] as String,
      jobOwnerName: fields[2] as String,
      taskTitle: fields[5] as String,
      taskDescription: fields[6] as String,
      startDate: fields[7] as DateTime,
      endDate: fields[8] as DateTime,
      status: fields[9] as TaskStatusEnum,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.jobOwnerId)
      ..writeByte(2)
      ..write(obj.jobOwnerName)
      ..writeByte(3)
      ..write(obj.freelancerId)
      ..writeByte(4)
      ..write(obj.freelancerName)
      ..writeByte(5)
      ..write(obj.taskTitle)
      ..writeByte(6)
      ..write(obj.taskDescription)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
