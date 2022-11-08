import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TsakWidget extends StatefulWidget {
  TsakWidget({Key? key , required }) : super(key: key);

  @override
  State<TsakWidget> createState() => _TsakWidgetState();
}

class _TsakWidgetState extends State<TsakWidget> {
  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Container getTaskItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
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
    );
  }

  Row getMainItem() {
    bool isChecked = false;

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
                  MSHCheckbox(
                    size: 30,
                    value: isChecked,
                    //isDisabled: isDisabled,
                    checkedColor: Color(0xff18DAA3),
                    uncheckedColor: Colors.black12,
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {
                      setState(
                        () {
                          isChecked = selected;
                        },
                      );
                    },
                  ),
                  //Spacer(),
                  Text('data reade')
                ],
              ),
              Text('data'),
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

  Row getTmeAndEditBadge() {
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
                Text(
                  '10:30',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
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
        )
      ],
    );
  }
}
