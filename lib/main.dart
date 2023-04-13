import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/note.dart';

import 'package:note_application/widgets/home_screen.dart';
import 'package:note_application/widgets/note_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'data/enum_task.dart';
import 'data/task.dart';
import 'data/task_type.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(taskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  await Hive.openBox<Note>('NoteBox');
  visualDensity:
  VisualDensity.adaptivePlatformDensity;
  runApp(MaterialApp(home: SplashScreen()));
}

class AnimationStart extends StatefulWidget {
  const AnimationStart({Key? key}) : super(key: key);

  @override
  State<AnimationStart> createState() => _AnimationStartState();
}

class _AnimationStartState extends State<AnimationStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/notebook.jpg',
          ),
          duration: 3000,
          splashIconSize: 300,
          pageTransitionType: PageTransitionType.fade,
          animationDuration: Duration(seconds: 1),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: Color(0xff18DAA3),
          nextScreen: MainScreen(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return MainScreen();
          }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Color(0xff18DAA3)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeTransition(
                          opacity: animation!,
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "Write Your Note",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Color(0xff18DAA3),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Loading...",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool isDarkModeEnable = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkModeEnable ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xff18DAA3),
          actions: [
            Switch(
                activeColor: Colors.grey,
                value: isDarkModeEnable,
                onChanged: (value) {
                  setState(() {
                    isDarkModeEnable = !isDarkModeEnable;
                  });
                })
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: getLayout(),
        ),
        bottomNavigationBar: SizedBox(
          height: 91,
          child: BottomNavigationBar(
            elevation: 1,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'ToDo',
                backgroundColor: Color(0xff18DAA3),
                activeIcon: Icon(
                  Icons.indeterminate_check_box_outlined,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note_add),
                label: 'Note',
                backgroundColor: Color(0xff18DAA3),
                activeIcon: Icon(
                  Icons.note_add_outlined,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'setting',
                activeIcon: Icon(Icons.settings_rounded),
                backgroundColor: Color.fromARGB(255, 15, 114, 86),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            // backgroundColor: Color(0xff18DAA3),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  List<Widget> getLayout() {
    return <Widget>[
      HomeScreen(),
      NoteScreen(),
      Container(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

final darkTheme = ThemeData(
  fontFamily: 'SM',
  textTheme: TextTheme(
    headline4: TextStyle(
      fontFamily: 'SM',
      fontSize: 18,
      //color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff424242) //Color.fromARGB(255, 3, 116, 5),
      ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 94, 92, 92),
  ),
  accentColor: Colors.white,
  scaffoldBackgroundColor: Color(0xff252525), // Color.fromARGB(255, 2, 74, 3),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff212121),
  ),
);
final lightTheme = ThemeData(
  fontFamily: 'SM',
  textTheme: TextTheme(
    headline4: TextStyle(
      fontFamily: 'SM',
      fontSize: 18,
      //color: Colors.white,
    ),
  ),
  //brightness: Brightness.light,
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: Color(0xff18DAA3)),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff18DAA3)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff18DAA3),
  ),
  primarySwatch: Colors.blue,
  accentColor: Colors.black,
  scaffoldBackgroundColor: Color.fromARGB(250, 214, 213, 213),
);
