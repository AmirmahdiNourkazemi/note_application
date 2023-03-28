import 'package:flutter/material.dart';
import 'package:note_application/data/note.dart';

class NoteWidget extends StatefulWidget {
  Note note;
  NoteWidget({super.key, required this.note});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(widget.note.subject),
          Text(widget.note.explane),
        ],
      ),
    );
  }
}
