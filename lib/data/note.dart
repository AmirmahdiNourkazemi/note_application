import 'package:hive/hive.dart';
part 'note.g.dart';
@HiveType(typeId: 2)
class Note extends HiveObject {
  @HiveField(1)
  String subject;
  @HiveField(2)
  String explane;
  Note({required  this.explane, required this.subject});
}
