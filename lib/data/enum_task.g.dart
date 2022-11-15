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
      case 7:
        return taskTypeEnum.study;
      case 8:
        return taskTypeEnum.wake_up;
      case 9:
        return taskTypeEnum.rest;
      case 10:
        return taskTypeEnum.listenToMusic;
      case 11:
        return taskTypeEnum.goToClass;
      case 12:
        return taskTypeEnum.plannig;
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
      case taskTypeEnum.study:
        writer.writeByte(7);
        break;
      case taskTypeEnum.wake_up:
        writer.writeByte(8);
        break;
      case taskTypeEnum.rest:
        writer.writeByte(9);
        break;
      case taskTypeEnum.listenToMusic:
        writer.writeByte(10);
        break;
      case taskTypeEnum.goToClass:
        writer.writeByte(11);
        break;
      case taskTypeEnum.plannig:
        writer.writeByte(12);
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
