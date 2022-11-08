import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/car.dart';
import 'package:note_application/home_screen.dart';
import 'package:note_application/student.dart';

void main() async {
  await Hive.initFlutter();
  // var box = await Hive.openBox('name');
  //Hive.registerAdapter(CarAdapter());
  //await Hive.openBox<Car>('carBox');
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('studentBox');
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
