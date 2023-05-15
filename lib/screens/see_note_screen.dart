import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../data/note.dart';

class SeeNoteScreen extends StatefulWidget {
  SeeNoteScreen(this.index, this.note, {super.key});
  Note note;
  int index;
  @override
  State<SeeNoteScreen> createState() => _SeeNoteScreenState();
}

class _SeeNoteScreenState extends State<SeeNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: TextStyle(fontFamily: 'SM', fontSize: 20),
                text: '${widget.note.subject}'),
          ),
        ),

        //backgroundColor: Color(0xff18DAA3),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            '${widget.note.explane}',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 20),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
