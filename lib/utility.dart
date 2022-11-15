import 'package:note_application/enum_task.dart';
import 'package:note_application/task_type.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'assets/images/meditate.png',
        title: 'تمرکز کردن',
        taskTypeEnum: taskTypeEnum.foucs),
    TaskType(
        image: 'assets/images/work_meeting.png',
        title: 'میتینگ',
        taskTypeEnum: taskTypeEnum.date),
    TaskType(
        image: 'assets/images/hard_working.png',
        title: 'مشغول به کار',
        taskTypeEnum: taskTypeEnum.working),
    TaskType(
        image: 'assets/images/workout.png',
        title: 'ورزش کردن',
        taskTypeEnum: taskTypeEnum.exersice),
    TaskType(
        image: 'assets/images/banking.png',
        title: 'امور بانکی',
        taskTypeEnum: taskTypeEnum.working),
    TaskType(
        image: 'assets/images/go_out.jpg',
        title: 'بریم بیرون',
        taskTypeEnum: taskTypeEnum.goOut),
    TaskType(
        image: 'assets/images/social_frends.png',
        title: 'خوش گذرونی',
        taskTypeEnum: taskTypeEnum.friends),
    TaskType(
        image: 'assets/images/programming.jpg',
        title: 'برنامه نویسی',
        taskTypeEnum: taskTypeEnum.programming),
  ];
  return list;
}
