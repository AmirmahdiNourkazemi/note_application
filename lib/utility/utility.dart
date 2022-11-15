import '../data/task_type.dart';
import '../data/enum_task.dart';

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
    TaskType(
        image: 'assets/images/go_to_class.jpg',
        title: 'سرکلاس',
        taskTypeEnum: taskTypeEnum.goToClass),
    TaskType(
        image: 'assets/images/listen_to_music.jpg',
        title: 'موزیک',
        taskTypeEnum: taskTypeEnum.listenToMusic),
    TaskType(
        image: 'assets/images/planning.jpg',
        title: 'برنامه ریزی',
        taskTypeEnum: taskTypeEnum.plannig),
    TaskType(
        image: 'assets/images/rest.jpg',
        title: 'استراحت کردن',
        taskTypeEnum: taskTypeEnum.rest),
    TaskType(
        image: 'assets/images/study.jpg',
        title: 'درس خوندن',
        taskTypeEnum: taskTypeEnum.study),
    TaskType(
        image: 'assets/images/wake_up.jpg',
        title: 'بیدار شدن',
        taskTypeEnum: taskTypeEnum.wake_up),
  ];
  return list;
}
