// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class taskTypeEnumAdapter extends TypeAdapter<taskTypeEnum> {
  @override
  final int typeId = 5;

  @override
  taskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return taskTypeEnum.working;
      case 1:
        return taskTypeEnum.foucs;
      case 2:
        return taskTypeEnum.date;
      case 3:
        return taskTypeEnum.exersice;
      case 4:
        return taskTypeEnum.goOut;
      case 5:
        return taskTypeEnum.friends;
      case 6:
        return taskTypeEnum.programming;
      default:
        return taskTypeEnum.working;
    }
  }

  @override
  void write(BinaryWriter writer, taskTypeEnum obj) {
    switch (obj) {
      case taskTypeEnum.working:
        writer.writeByte(0);
        break;
      case taskTypeEnum.foucs:
        writer.writeByte(1);
        break;
      case taskTypeEnum.date:
        writer.writeByte(2);
        break;
      case taskTypeEnum.exersice:
        writer.writeByte(3);
        break;
      case taskTypeEnum.goOut:
        writer.writeByte(4);
        break;
      case taskTypeEnum.friends:
        writer.writeByte(5);
        break;
      case taskTypeEnum.programming:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is taskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
