import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../notification/notification.dart';
import '../utility/utility.dart';
import '../widgets/task_type_item.dart';

DateTime scheduleTime = DateTime.now();

class editTsakWidget extends StatefulWidget {
  editTsakWidget({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<editTsakWidget> createState() => _editTsakWidgetState();
}

class _editTsakWidgetState extends State<editTsakWidget> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerSubTaskTitle;
  DateTime? _time;
  int SelectedType = 0;
  final box = Hive.box<Task>('taskBox');
  DateTime scheduleTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    DatePickerTxt().getTime();
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerSubTaskTitle = TextEditingController(text: widget.task.subTitle);
    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    SelectedType = index;
    print(SelectedType);
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff424242),
      body: SafeArea(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'تسک ها',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: negahban1.hasFocus
                            ? Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff18DAA3)
                                : Colors.black
                            : Color(0xff18DAA3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerSubTaskTitle,
                    maxLines: 3,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'عنوان تسک ها',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: negahban2.hasFocus
                            ? Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff18DAA3)
                                : Colors.black
                            : Color(0xff18DAA3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              DatePickerTxt(),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(
                          () {
                            SelectedType = index;
                          },
                        );
                      },
                      child: taskTypeList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItem: SelectedType,
                      ),
                    );
                  }),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  String task1 = controllerTaskTitle!.text;
                  String task2 = controllerSubTaskTitle!.text;
                  DateTime time = await DatePickerTxt().getTime();
                  addTask(task1, task2, time);
                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff18DAA3),
                  minimumSize: Size(200, 40),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addTask(String task, String subTask, DateTime time) async {
    widget.task.title = task;
    widget.task.subTitle = subTask;
    widget.task.time = await time;
    widget.task.taskType = getTaskTypeList()[SelectedType];
    widget.task.save();
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);
  Future<DateTime> getTime() async {
    return scheduleTime;
  }

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  Future<DateTime> getTime() async {
    return scheduleTime;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // primary: Colors.blue,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromARGB(255, 94, 92, 92)
            : Color(0xff18DAA3),
        minimumSize: Size(200, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) async {
            scheduleTime = date;
            Future<DateTime> getTime() async {
              return scheduleTime = date;
            }

            NotificationService().scheduleNotification(
              title: 'Scheduled Notification',
              body: '$scheduleTime',
              scheduledNotificationDateTime: scheduleTime,
            );
          },
          onConfirm: (date) {
            final snackBar = SnackBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromARGB(255, 94, 92, 92)
                  : Colors.white,
              content: Text(
                'ساعت با موفقیت تنظیم شد',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'SM',
                ),
              ),
              action: SnackBarAction(
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                label: 'حله',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },
      child: const Text(
        'ساعت رو انتخاب کن',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
          title: 'Scheduled Notification',
          body: '$scheduleTime',
          scheduledNotificationDateTime: scheduleTime,
        );
      },
    );
  }
}
