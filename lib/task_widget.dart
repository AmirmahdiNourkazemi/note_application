import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_application/edit_task_screen.dart';
import 'package:note_application/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
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
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: Color(0XFFFFFFFFF),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: getMainItem(),
        ),
      ),
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
                  Checkbox(
                      value: isBoxChecked,
                      onChanged: (isChecked) {
                        isBoxChecked = isChecked!;
                      }),
                  //Spacer(),
                  Text(
                    widget.task.title,
                  )
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
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
        Image.asset('assets/images/workout.png'),
      ],
    );
  }

  Column getTitle() {
    return Column(
      children: [
        Text('salam'),
        Text('salam'),
        getTmeAndEditBadge(),
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
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
            child: Row(
              children: [
                Image.asset('assets/images/icon_time.png'),
                SizedBox(
                  width: 5,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Text(
                      '${widget.task.time.hour}:${getMinute(widget.task.time)}',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/icon_edit.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 200, 144),
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
