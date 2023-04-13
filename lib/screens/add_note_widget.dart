import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:hive/hive.dart';
import 'package:note_application/data/note.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../data/task.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  int SelectedType = 0;

  final TextEditingController controllerTaskTitle = TextEditingController();
  //final TextEditingController controllerSubTaskTitle = TextEditingController();
  QuillController controllerSubTaskTitle = QuillController.basic();
  final box = Hive.box<Note>('NoteBox');

  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 20,
                      color: negahban1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color.fromARGB(255, 224, 223, 223),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
                              : Color(0xff18DAA3),
                          width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xff18DAA3)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 44),
            //   child: Directionality(
            //     textDirection: TextDirection.rtl,
            //     // child: Column(
            //     //   children: [
            //     //     ZefyrToolbar.basic(controller: _controller),
            //     //     Expanded(
            //     //       child: ZefyrEditor(
            //     //         controller: _controller,
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),

            //     child: TextField(
            //       controller: controllerSubTaskTitle,
            //       maxLines: 3,
            //       focusNode: negahban2,
            //       decoration: InputDecoration(
            //         contentPadding:
            //             EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //         labelText: 'متن',
            //         labelStyle: TextStyle(
            //           fontSize: 20,
            //           color: negahban2.hasFocus
            //               ? Color(0xff18DAA3)
            //               : Color.fromARGB(255, 46, 45, 45),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(15)),
            //           borderSide:
            //               BorderSide(color: Color(0xffC5C5C5), width: 3.0),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(15)),
            //           borderSide: BorderSide(
            //             width: 3,
            //             color: Color(0xff18DAA3),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 650,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xff18DAA3)
                            : Colors.white,
                        width: 3.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      QuillToolbar.basic(controller: controllerSubTaskTitle),
                      Container(
                        child: QuillEditor.basic(
                          controller: controllerSubTaskTitle,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 85),
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
                      String task1 = controllerTaskTitle.text;
                      String task2 =
                          controllerSubTaskTitle.document.toDelta().toString();
                      ;
                      addNote(task2, task1);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اضافه کردن نوت',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
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

  addNote(String task, String subTask) {
    var allNote = Note(
      explane: task,
      subject: subTask,
    );
    box.add(allNote);
  }
}
