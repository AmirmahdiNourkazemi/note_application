import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/note.dart';
import 'package:note_application/widgets/home_screen.dart';
import 'package:note_application/widgets/note_screen.dart';
import 'data/enum_task.dart';
import 'data/task.dart';
import 'data/task_type.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(taskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  await Hive.openBox<Note>('NoteBox');
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
        textTheme: TextTheme(
          headline4: TextStyle(
            fontFamily: 'SM',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text(
            'برنامه بده',
            style: TextStyle(fontSize: 20, fontFamily: 'SM'),
          ),
          backgroundColor: Color(0xff18DAA3),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: getLayout(),
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
      ),
    );
  }

  List<Widget> getLayout() {
    return <Widget>[
      HomeScreen(),
      NoteScreen(),
      Container(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
