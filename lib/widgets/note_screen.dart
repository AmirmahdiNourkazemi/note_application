import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_application/data/note.dart';
import 'package:note_application/screens/add_note_widget.dart';
import 'package:note_application/screens/edit_note_screen.dart';
import 'package:note_application/widgets/note_widget.dart';

import '../screens/add_task_widget.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Note? note;
  var taskBox = Hive.box<Note>('NoteBox');
  bool isFabVisible = true;
  bool isSelected = true;
  bool isLongPress = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      var taskBox = Hive.box<Note>('NoteBox');
    });
    return Scaffold(
      //backgroundColor: Color.fromARGB(250, 214, 213, 213),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3,
                    crossAxisCount: 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                            EditNote(index, note: note!);
                          });
                        },
                        onLongPress: () {
                          //isLongPress = true;
                          setState(() {
                            isLongPress = !isLongPress;
                          });
                          //   _showContextMenu(
                          //       context, taskBox.values.toList()[index]);
                        },
                        child: //getNote(taskBox.values.toList()[index], index)
                            getListItem(taskBox.values.toList()[index], index),
                      );
                    },
                    childCount: taskBox.values.length,
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.normal,
                color: Color.fromARGB(255, 85, 85, 85),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            heroTag: "btn2",
            elevation: 0,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNote(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            //backgroundColor: Color(0xff18DAA3),
          ),
        ),
      ),
    );
  }

  Widget getNote(Note note, index) {
    return GestureDetector(
      child: Expanded(
        child: Stack(
          children: [
            NoteWidget(
              index: index,
              note: taskBox.values.toList()[index],
              longPress: isLongPress,
            ),
            Checkbox(
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
          ],
        ),
      ),
    );
  }

  Widget getListItem(Note note, index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            note.delete();
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${note.subject} deleted")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${note.subject} go to edit screen")));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNote(
                index,
                note: note,
              ),
            ),
          );
        }
      },
      background: Container(
        height: 100,
        color: Color(0xff18DAA3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.edit, color: Colors.white, size: 40),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
      child: NoteWidget(
        index: index,
        note: taskBox.values.toList()[index],
        longPress: isLongPress,
      ),
    );
    // return Dismissible(
    //   key: UniqueKey(),
    //   onDismissed: (direction) {
    //     note.delete();
    //   },
    //   child: NoteWidget(
    //     note: taskBox.values.toList()[index],
    //     longPress: isLongPress,
    //   ),
    // );
  }

  void _showContextMenu(BuildContext context, Note note) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    final result =
        await showMenu(context: context, position: RelativeRect.fill, items: [
      const PopupMenuItem(
        child: Text('delete'),
        value: "fav",
      ),
      const PopupMenuItem(
        child: Text('Close'),
        value: "close",
      )
    ]);
    // perform action on selected menu item
    switch (result) {
      case 'delete':
        note.delete();
        break;
      case 'close':
        print('close');
        Navigator.pop(context);
        break;
    }
  }
}

class FancyFab extends StatefulWidget {
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController? _animationController;
  Animation<Color?>? _animateColor;
  Animation<double>? _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor!.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
