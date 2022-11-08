import 'package:hive/hive.dart';


part 'student.g.dart';


@HiveType(typeId: 2)
class Student {
  @HiveField(0)
  String name;
  @HiveField(1)
  String familly;
  @HiveField(2)
  double grade;
  @HiveField(3)
  int age;
  Student(
      {required this.name,
      required this.age,
      required this.familly,
      required this.grade});
}
