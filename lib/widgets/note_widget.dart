import 'package:flutter/material.dart';
import 'package:note_application/data/note.dart';

class NoteWidget extends StatefulWidget {
  Note note;
  bool longPress;
  NoteWidget({super.key, required this.note, required this.longPress});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 500,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.longPress,
              child: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  activeColor: Color(0xff18DAA3),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                widget.note.explane
                    .replaceAll('<', '')
                    .replaceAll('>', '')
                    .replaceAll('insert', '')
                    .replaceAll('+', ''),
                style: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            //Text(widget.note.explane),
          ],
        ),
      ),
    );
  }
}
