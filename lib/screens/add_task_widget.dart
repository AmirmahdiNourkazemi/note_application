import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/task.dart';
import '../notification/notification.dart';
import '../utility/utility.dart';
import '../widgets/animation_sequience.dart';
import '../widgets/task_type_item.dart';

DateTime scheduleTime = DateTime.now();

class addTsakWidget extends StatefulWidget {
  addTsakWidget({Key? key}) : super(key: key);

  @override
  State<addTsakWidget> createState() => _addTsakWidgetState();
}

class _addTsakWidgetState extends State<addTsakWidget> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DateTime? selectedTime;
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  int SelectedType = 0;

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerSubTaskTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    DatePickerTxt().getTime();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(
      () {
        setState(() {});
      },
    );

    //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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
                height: 20,
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
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
                              : Color(0xff18DAA3),
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
                        fontSize: 20,
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
                              : Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: Text('Select Time'),
              //   onPressed: () => _selectTime(context),
              // ),
              // NotificationScreen()
              SizedBox(
                height: 50,
              ),
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
              ),
              SizedBox(
                height: 40,
              ),

              Text(
                'عکسی که دوس داری رو انتخاب کن',
                style: TextStyle(fontFamily: 'SM', fontSize: 18),
              ),
              SizedBox(
                height: 25,
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
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String task1 = controllerTaskTitle.text;
                        String task2 = controllerSubTaskTitle.text;
                        DateTime time = await DatePickerTxt().getTime();
                        NotificationService().scheduleNotification(
                          title: task1,
                          body: task2,
                          scheduledNotificationDateTime: time,
                        );
                        if (DateTime.now().compareTo(time) > 0) {
                          final snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 94, 92, 92)
                                    : Colors.white,
                            content: Text(
                              'ساعت را درست انتخاب کن',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'SM',
                              ),
                            ),
                            action: SnackBarAction(
                              textColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color.fromARGB(255, 177, 176, 176)
                                  : Colors.black,
                              label: 'حله',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        addTask(task1, task2, time);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'اضافه کردن تسک',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addTask(String task, String subTask, DateTime time) async {
    var allTask = Task(
      title: task,
      subTitle: subTask,
      time: await time,
      taskType: getTaskTypeList()[SelectedType],
    );
    box.add(allTask);
    //print(box.get(1)!.title);
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
