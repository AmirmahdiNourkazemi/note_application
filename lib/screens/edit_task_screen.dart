import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
  var title;
  var subTitle;
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
    setState(() {
      title = widget.task.title;
      subTitle = widget.task.subTitle;
      controllerTaskTitle = TextEditingController(text: widget.task.title);
      controllerSubTaskTitle =
          TextEditingController(text: widget.task.subTitle);
    });
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
              // GestureDetector(
              //   onTap: () {
              //     setState(() async {
              //       title = await widget.task.title;
              //       subTitle = await widget.task.subTitle;
              //     });
              //   },

              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // primary: Colors.blue,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromARGB(255, 94, 92, 92)
                          : Color(0xff18DAA3),
                  minimumSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  NotificationDetails(
                    android:
                        AndroidNotificationDetails('channelId', 'channelName'),
                  );
                  DatePicker.showDateTimePicker(
                    context,
                    onCancel: () {},
                    theme: DatePickerTheme(
                      containerHeight: 90,
                      cancelStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff424242),
                      ),
                      doneStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff424242),
                      ),
                      titleHeight: 60,
                      itemHeight: 40,
                      itemStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff424242),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Color(0xff424242),
                    ),
                    minTime: DateTime.now(),
                    showTitleActions: true,
                    onChanged: (date) {
                      scheduleTime = date;
                    },
                    onConfirm: (date) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        // backgroundColor:
                        //     Theme.of(context).brightness == Brightness.dark
                        //         ? Color.fromARGB(255, 94, 92, 92)
                        //         : Colors.white,
                        content: AwesomeSnackbarContent(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff18DAA3)
                                  : Color(0xff424242),
                          title: '!!تایم با موفقیت ست شد',
                          message: '${date}',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                          // to configure for material banner
                          inMaterialBanner: false,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
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
              ),
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
                  DateTime time = widget.task.time;

                  Future<DateTime> getTime() async {
                    return scheduleTime = time;
                  }

                  NotificationService().scheduleNotification(
                    title: task1,
                    body: task2,
                    scheduledNotificationDateTime: scheduleTime,
                  );

                  if (DateTime.now().compareTo(scheduleTime) > 0) {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: '!!تایم نادرست است',
                        message: 'لطفا تایم را درست کنید و دوباره امتحان کنید',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                        // to configure for material banner
                        inMaterialBanner: false,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return;
                  }
                  if (DateTime.now().compareTo(scheduleTime) < 0) {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'تسک با موفقیت ادیت شد',
                        message: 'دیگه نگران چیزی نباش',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.success,
                        // to configure for material banner
                        inMaterialBanner: false,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                  addTask(task1, task2, scheduleTime);
                  Navigator.pop(context);
                },
                child: Text(
                  'ادیت کردن تسک',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color(0xff18DAA3)
                        : Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromARGB(255, 94, 92, 92)
                          : Color(0xff18DAA3),
                  minimumSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
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
  DatePickerTxt({Key? key, this.title})
      : super(
          key: key,
        );
  String? title;
  Future<DateTime> getTime() async {
    return scheduleTime;
  }

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
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
        NotificationDetails(
          android: AndroidNotificationDetails('channelId', 'channelName'),
        );
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) {
            scheduleTime = date;
            NotificationService().scheduleNotification(
              title: 'Scheduled Notification',
              body: '$scheduleTime',
              scheduledNotificationDateTime: scheduleTime,
            );
          },
          onConfirm: (date) {},
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
          title: '',
          body: '$scheduleTime',
          scheduledNotificationDateTime: scheduleTime,
        );
      },
    );
  }
}
