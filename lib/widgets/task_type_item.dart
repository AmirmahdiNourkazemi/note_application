import 'package:flutter/material.dart';

import '../data/task_type.dart';

class taskTypeList extends StatelessWidget {
  taskTypeList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItem})
      : super(key: key);
  TaskType taskType;
  int index;
  int selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: (selectedItem == index) ? Colors.green : Colors.transparent,
        border: Border.all(
          color: (selectedItem == index) ? Colors.green : Colors.transparent,
          width: 3,
        ),
      ),
      width: 140,
      margin: EdgeInsets.all(8),
      //color: Colors.green,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              color: (selectedItem == index) ? Colors.white : Colors.black,
              fontSize: (selectedItem == index) ? 22 : 18,
            ),
          ),
        ],
      ),
    );
  }
}
