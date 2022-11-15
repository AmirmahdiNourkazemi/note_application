import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/widgets/home_screen.dart';

import 'data/enum_task.dart';
import 'data/task.dart';
import 'data/task_type.dart';

void main() async {
  await Hive.initFlutter();
  // var box = await Hive.openBox('name');
  //Hive.registerAdapter(CarAdapter());
  //await Hive.openBox<Car>('carBox');
  //Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(taskTypeEnumAdapter());
  //await Hive.openBox<Student>('studentBox');
  await Hive.openBox<Task>('taskBox');
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
      home: HomeScreen(),
    );
  }
}
