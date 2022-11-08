import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_application/student.dart';
import 'package:note_application/task_widget.dart';
import 'car.dart';
import 'student.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputdata = '';

  var controller = TextEditingController();
  //var box = Hive.box('name');
  //var carBox = Hive.box<Car>('carBox');
  var studentBox = Hive.box<Student>('studentBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 182, 182, 182),
      body: Center(
        child: TsakWidget(),
      ),
    );
  }
}
