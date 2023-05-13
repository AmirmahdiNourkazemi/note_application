import 'package:flutter/material.dart';

//LightTheme
ThemeData lightTheme = ThemeData(
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

TextStyle lightTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.black,
);
TextTheme lightTextTheme = TextTheme(
  bodyText1: lightTextStyle,
);

//DarkTheme
ThemeData darkTheme = ThemeData(
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

TextStyle darkTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);
TextTheme darkTextTheme = TextTheme(
  bodyText1: lightTextStyle,
);
