import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/task.dart';

class addTsakWidget extends StatefulWidget {
  addTsakWidget({Key? key}) : super(key: key);

  @override
  State<addTsakWidget> createState() => _addTsakWidgetState();
}

class _addTsakWidgetState extends State<addTsakWidget> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerSubTaskTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();
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
                height: 100,
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
                            : Colors.white,
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
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String task1 = controllerTaskTitle.text;
                  String task2 = controllerSubTaskTitle.text;
                  addTask(task1, task2);
                  Navigator.pop(context);
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff18DAA3), minimumSize: Size(200, 40)),
              )
            ],
          ),
        ),
      ),
    );
  }

  addTask(String task, String subTask) {
    var allTask = Task(title: task, subTitle: subTask);
    box.add(allTask);
    //print(box.get(1)!.title);
  }
}
