import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/widgets/note_screen.dart';
import 'package:note_application/widgets/task_widget.dart';

import '../data/task.dart';
import '../screens/add_task_widget.dart';
import '../screens/edit_task_screen.dart';

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
  var taskBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(250, 214, 213, 213),
      body: ToDoScreen(),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.normal,
                color: Color.fromARGB(255, 97, 107, 105),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            heroTag: "btn1",
            elevation: 0,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => addTsakWidget(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            //backgroundColor: Color(0xff18DAA3),
          ),
        ),
      ),
    );
  }

  Widget ToDoScreen() {
    return Center(
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
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            task.delete();
          });
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => editTsakWidget(task: task),
            ),
          );
        }
      },
      background: Container(
        color: Color(0xff18DAA3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.edit, color: Colors.white, size: 40),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
      child: TaskWidget(task: task),
    );
    // return Dismissible(
    //   key: UniqueKey(),
    //   onDismissed: (LongPressEndDetails) {
    //     task.delete();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('${task.title} removed'),
    //       ),
    //     );
    //   },
    //   background: Container(
    //     color: Colors.red,
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 30),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Icon(
    //             Icons.edit,
    //             size: 40,
    //           ),
    //           Icon(
    //             Icons.delete,
    //             size: 40,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   child: TaskWidget(task: task),
    // );
  }
}
