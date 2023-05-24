import 'package:flutter/material.dart';
import 'package:note_application/data/note.dart';
import 'package:note_application/screens/edit_note_screen.dart';
import 'package:note_application/screens/see_note_screen.dart';

class NoteWidget extends StatefulWidget {
  Note note;
  bool longPress;
  int index;
  NoteWidget(
      {super.key,
      required this.index,
      required this.note,
      required this.longPress});

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
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(94, 92, 92, 1)
              : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) {
                                return EditNote(widget.index,
                                    note: widget.note);
                              }),
                            ),
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) {
                                return SeeNoteScreen(widget.index, widget.note);
                              }),
                            ),
                          );
                        },
                        child: Icon(Icons.remove_red_eye),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'SM',
                                fontSize: 20),
                            text: '${widget.note.subject}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Text(widget.note.explane),
          ],
        ),
      ),
    );
  }
}
