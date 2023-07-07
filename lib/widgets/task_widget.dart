import 'package:flutter/material.dart';
import 'package:note_application/theme/color_schemes.g.dart';
import 'package:note_application/theme/themes.dart';
import 'package:provider/provider.dart';

import '../data/task.dart';
import '../models/ThemeNotifier.dart';
import '../screens/edit_task_screen.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  bool isBoxChecked = false;
  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => themeChangeProvider, child: getTaskItem());
  }

  Widget getTaskItem() {
    return Consumer<DarkThemeProvider>(
      builder: (context, themeProvider, child) {
        return InkWell(
          onTap: () {
            setState(() {
              isBoxChecked = !isBoxChecked;
              widget.task.isDone = isBoxChecked;
              widget.task.save();
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: getMainItem(),
            ),
          ),
        );
      },
    );
  }

  Row getMainItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: isBoxChecked,
                      onChanged: (isChecked) {
                        isBoxChecked = isChecked!;
                      },
                    ),
                  ),
                  //Spacer(),
                  Text(
                    widget.task.title,
                  )
                ],
              ),
              SizedBox(
                height: 20,
                child: Text(
                  widget.task.subTitle,
                  overflow: TextOverflow.clip,
                ),
              ),
              Spacer(),
              getTmeAndEditBadge()
            ],
          ),
        ),
        //Spacer(),
        //getTitle(),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 100,
          height: 200,
          child: Image.asset(widget.task.taskType.image),
        )
      ],
    );
  }

  Widget getTmeAndEditBadge() {
    return Row(
      children: [
        Container(
          height: 28,
          width: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${widget.task.time.hour}:${getMinute(widget.task.time)}',
                style: TextStyle(
                  fontSize: 15,
                  //color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => editTsakWidget(task: widget.task),
              ),
            );
          },
          child: Container(
            height: 28,
            width: 90,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    //color: Color(0xff18DAA3),
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      //color: Color(0xff18DAA3),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  String getMinute(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else
      return '${time.minute}';
  }
}
