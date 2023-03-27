import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../utility/utility.dart';
import '../widgets/task_type_item.dart';

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

  @override
  void initState() {
    super.initState();
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
                            ? Color(0xff18DAA3)
                            : Colors.white,
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
                            ? Color(0xff18DAA3)
                            : Color.fromARGB(255, 46, 45, 45),
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان تسک را مشخص کن',
                  negativeButtonText: 'حذف کن',
                  positiveButtonText: 'انتخاب زمان',
                  elevation: 2,
                  titleStyle: TextStyle(
                    color: Color(0xff18DAA3),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  negativeButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {},
                ),
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
                onPressed: () {
                  String task1 = controllerTaskTitle!.text;
                  String task2 = controllerSubTaskTitle!.text;
                  addTask(task1, task2);
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

  addTask(String task, String subTask) {
    widget.task.title = task;
    widget.task.subTitle = subTask;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[SelectedType];
    widget.task.save();
  }
}
