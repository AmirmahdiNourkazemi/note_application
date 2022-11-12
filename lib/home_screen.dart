import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_application/add_task_widget.dart';
import 'package:note_application/task.dart';
import 'package:note_application/task_widget.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputdata = '';
  bool isChecked = false;

  var controller = TextEditingController();
  //var box = Hive.box('name');
  //var carBox = Hive.box<Car>('carBox');
  //var studentBox = Hive.box<Student>('studentBox');
  var taskBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 182, 182, 182),
      body: ListView.builder(
        itemCount: taskBox.values.length,
        itemBuilder: (context, index) {
          var task = taskBox.values.toList()[index];
          return TaskWidget(task: task);
        },
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
