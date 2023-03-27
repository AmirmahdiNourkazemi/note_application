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
      appBar: AppBar(
        primary: true,
        title: Text(
          'برنامه بده',
          style: TextStyle(fontSize: 20, fontFamily: 'SM'),
        ),
        backgroundColor: Color(0xff18DAA3),
      ),
      backgroundColor: Color.fromARGB(250, 214, 213, 213),
      body: IndexedStack(
        index: _selectedIndex,
        children: getLayout(),
      ),
      floatingActionButton: Visibility(
        visible: _selectedIndex == 0 && isFabVisible ? true : false,
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
      bottomNavigationBar: SizedBox(
        height: 91,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'ToDo',
              backgroundColor: Color(0xff18DAA3),
              activeIcon: Icon(
                Icons.indeterminate_check_box_outlined,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Note',
              backgroundColor: Color(0xff18DAA3),
              activeIcon: Icon(
                Icons.note_add_outlined,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'setting',
              activeIcon: Icon(Icons.settings_rounded),
              backgroundColor: Color.fromARGB(255, 15, 114, 86),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Color(0xff18DAA3),
          onTap: _onItemTapped,
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
