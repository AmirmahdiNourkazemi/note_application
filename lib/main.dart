import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/calendar_screen.dart';
import 'package:note_application/data/note.dart';
import 'package:note_application/models/ThemeNotifier.dart';
import 'package:note_application/screens/feature_screen.dart';
import 'package:note_application/theme/color_schemes.g.dart';
import 'package:note_application/theme/themes.dart';
import 'package:note_application/widgets/cheque_screen.dart';
import 'package:note_application/widgets/home_screen.dart';
import 'package:note_application/widgets/note_screen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainScreen());
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

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeData(themeChangeProvider.darkTheme, context),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              key: _scaffoldKey,
              drawer: Drawer(
                child: Consumer<DarkThemeProvider>(
                  builder: (context, provider, child) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/robot-face.svg'),
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
                        ),
                        ListTile(
                          trailing: themeProvider.darkTheme == true
                              ? Icon(Icons.dark_mode)
                              : Icon(Icons.light_mode),
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
                                  //activeColor: Colors.white,
                                  value: themeProvider.darkTheme,
                                  onChanged: (value) {
                                    themeProvider.darkTheme =
                                        !themeProvider.darkTheme;
                                  },
                                  activeThumbImage:
                                      AssetImage('assets/images/moon.png'),
                                  inactiveThumbImage:
                                      AssetImage('assets/images/sun.png'),
                                ),
                              ),
                              Text(
                                themeProvider.darkTheme ==
                                        themeProvider.darkTheme
                                    ? 'حالت شب'
                                    : 'حالت روز',
                                textScaleFactor: 1.3,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Divider(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                        ListTile(
                          trailing: Icon(Icons.calendar_month),
                          subtitle: Text(
                            'کلیک کن تا تقویم رو ببینی',
                            textAlign: TextAlign.right,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'تقویم',
                                softWrap: true,
                                textScaleFactor: 1.3,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return CalendarScreen();
                              }),
                            );
                          },
                        ),
                        Divider(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                        ListTile(
                          trailing: Icon(Icons.money),
                          subtitle: Text(
                            'زمان چک خودتو بده',
                            textAlign: TextAlign.right,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'موعود چک',
                                softWrap: true,
                                textScaleFactor: 1.3,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ChequeScreen();
                              }),
                            );
                          },
                        ),
                        Divider(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                        ListTile(
                          trailing: Icon(Icons.person_rounded),
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
                      ],
                    );
                  },
                ),
              ),
              appBar: AppBar(
                title: Text('سر وقت باش'),
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
                  backgroundColor:
                      themeProvider.darkTheme ? onInverseSurface : primary,
                  elevation: 1,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.check_box),
                      label: 'ToDo',
                      //backgroundColor: Color(0xff18DAA3),
                      activeIcon: Icon(
                        Icons.indeterminate_check_box_outlined,
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.note_add,
                      ),
                      label: 'Note',
                      //backgroundColor: Color(0xff18DAA3),
                      activeIcon: Icon(
                        Icons.note_add_outlined,
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.rocket_launch),
                      label: 'feature',
                      activeIcon: Icon(
                        Icons.rocket_launch_outlined,
                        color: primaryContainer,
                      ),
                      //backgroundColor: Color.fromARGB(255, 15, 114, 86),
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
        },
      ),
    );
  }

  List<Widget> getLayout() {
    return <Widget>[
      HomeScreen(),
      NoteScreen(),
      featureScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
