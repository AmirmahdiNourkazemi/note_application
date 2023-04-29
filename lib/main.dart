import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/note.dart';
import 'package:note_application/screens/feature_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:note_application/widgets/home_screen.dart';
import 'package:note_application/widgets/note_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'data/enum_task.dart';
import 'data/task.dart';
import 'data/task_type.dart';
import 'notification/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

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
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await setup();
  runApp(MainScreen()
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: SplashScreen(),
      // ),
      );
}

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> setup() async {
  const androidInitializationSetting =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
      android: androidInitializationSetting, iOS: iosInitializationSetting);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  bool isDarkModeEnable = false;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkModeEnable ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(255, 94, 92, 92)
                      : Color(0xff18DAA3),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/robot-face.svg'),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      '!!!سلام من میتونم بهت کمک کنم',
                      textScaleFactor: 1.1,
                    )
                  ],
                ),
              ),
              ListTile(
                subtitle: Text(
                  '!!اینجا میتونی تم اپلیکیشن رو عوض کنی',
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Switch(
                        splashRadius: 2.1,
                        activeColor: Colors.white,
                        value: isDarkModeEnable,
                        onChanged: (value) {
                          setState(
                            () {
                              isDarkModeEnable = !isDarkModeEnable;
                            },
                          );
                        },
                        activeThumbImage: AssetImage('assets/images/moon.png'),
                        inactiveThumbImage: AssetImage('assets/images/sun.png'),
                      ),
                    ),
                    Text(
                      isDarkModeEnable ? 'حالت شب' : 'حالت روز',
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey
                    : Colors.white,
              ),
              ListTile(
                subtitle: Text(
                  'میخوای درباره من بدونی ؟',
                  textAlign: TextAlign.right,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'درباره من',
                      softWrap: true,
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
                onTap: () {
                  print('object');
                },
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey
                    : Colors.white,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 32,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          //backgroundColor: Color(0xff18DAA3),
          actions: [],
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
                icon: Icon(Icons.rocket_launch),
                label: 'feature',
                activeIcon: Icon(Icons.rocket_launch_outlined),
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
      featureScreen(isDarkModeEnable),
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
