import 'package:hive/hive.dart';

part 'enum_task.g.dart';

@HiveType(typeId: 5)
enum taskTypeEnum {
  @HiveField(0)
  working,
  @HiveField(1)
  foucs,
  @HiveField(2)
  date,
  @HiveField(3)
  exersice,
  @HiveField(4)
  goOut,
  @HiveField(5)
  friends,
  @HiveField(6)
  programming,
  @HiveField(7)
  study,
  @HiveField(8)
  wake_up,
  @HiveField(9)
  rest,
  @HiveField(10)
  listenToMusic,
  @HiveField(11)
  goToClass,
  @HiveField(12)
  plannig
}
