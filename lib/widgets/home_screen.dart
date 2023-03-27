import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/widgets/note_screen.dart';
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
  int _selectedIndex = 0;
  bool isChecked = false;
  bool isFabVisible = true;

  var controller = TextEditingController();
  var taskBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 214, 213, 213),
      body: ToDoScreen(),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.normal,
                color: Color.fromARGB(255, 15, 114, 86),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            elevation: 0,
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

  List<Widget> getLayout() {
    return <Widget>[
      ToDoScreen(),
      NoteScreen(),
      Container(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
