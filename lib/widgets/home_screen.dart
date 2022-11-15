import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/widgets/task_widget.dart';

import '../data/task.dart';
import '../screens/add_task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputdata = '';
  bool isChecked = false;
  bool isFabVisible = true;

  var controller = TextEditingController();
  //var box = Hive.box('name');
  //var carBox = Hive.box<Car>('carBox');
  //var studentBox = Hive.box<Student>('studentBox');
  var taskBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 214, 213, 213),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: ((context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notif) {
                setState(() {
                  if (notif.direction == ScrollDirection.forward) {
                    isFabVisible = true;
                  }
                  if (notif.direction == ScrollDirection.reverse) {
                    isFabVisible = false;
                  }
                });
                return true;
              },
              child: ListView.builder(
                itemCount: taskBox.values.length,
                itemBuilder: (context, index) {
                  var task = taskBox.values.toList()[index];
                  return getListItem(task);
                },
              ),
            );
          }),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => addTsakWidget(),
              ),
            );
          },
          child: Image.asset('assets/images/icon_add.png'),
          backgroundColor: Color(0xff18DAA3),
        ),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}
