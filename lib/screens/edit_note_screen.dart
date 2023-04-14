import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:hive/hive.dart';

import '../data/note.dart';

class EditNote extends StatefulWidget {
  EditNote(this.index, {required this.note, super.key});
  Note note;
  int index;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerSubTaskTitle;
  //QuillController? controllerSubTaskTitle;
  int SelectedType = 0;
  //Box<dynamic>? quillBox;

  final box = Hive.box<Note>('NoteBox');

  @override
  Widget build(BuildContext context) {
    setState(() {
      controllerTaskTitle = TextEditingController(text: widget.note.subject);
      controllerSubTaskTitle = TextEditingController(text: widget.note.explane);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'موضوع',
                    labelStyle: TextStyle(
                      fontSize: 26,
                      color: negahban1.hasFocus
                          ? Color(0xff18DAA3)
                          : Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff18DAA3)
                              : Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerSubTaskTitle,
                  maxLines: 30,
                  focusNode: negahban2,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'متن',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      color: negahban2.hasFocus
                          ? Color(0xff18DAA3)
                          : Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff18DAA3)
                              : Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Directionality(
            //   textDirection: TextDirection.rtl,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Container(
            //       height: 650,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Color(0xffC5C5C5), width: 3.0),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       child: Column(
            //         children: [
            //           QuillToolbar.basic(controller: controllerSubTaskTitle!),
            //           Container(
            //             child: QuillEditor.basic(
            //               controller: controllerSubTaskTitle!,
            //               readOnly: true, // true for view only mode
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String task1 = controllerTaskTitle!.text;
                      String task2 = controllerSubTaskTitle!.text;

                      addNote(task1, task2);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اضافه کردن نوت',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xff18DAA3)
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 46, 45, 45)
                              : Colors.white,
                      minimumSize: Size(200, 40),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _loadData() async {
  //   final jsonString = quillBox!.get('data') as String;
  //   if (jsonString != null) {
  //     final jsonData = jsonDecode(jsonString);
  //     final doc = Document.fromJson(jsonData);
  //     setState(() {
  //       controllerSubTaskTitle!
  //           .replaceText(widget.note.explane, widget.note.explane.length);
  //     });
  //   }
  // }

  addNote(String task, String subTask) {
    widget.note.subject = task;
    widget.note.explane = subTask;
    widget.note.save();
  }
}
