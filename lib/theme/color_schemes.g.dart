import 'package:flutter/material.dart';

const darkPrimary = Color(0xFFA5C8FF),
    darkOnPrimary = Color(0xFF00315E),
    darkPrimaryContainer = Color(0xFF004785),
    darkOnPrimaryContainer = Color(0xFFD4E3FF),
    darkSecondary = Color(0xFFB0C6FF),
    DarkOnSecondary = Color(0xFF002D6F),
    DarkSecondaryContainer = Color(0xFF00429C),
    onInverseSurface = Color(0xFF1A1C1E);
//ligt color
const primary = Color(0xFF005FAE),
    onPrimary = Color(0xFFFFFFFF),
    primaryContainer = Color(0xFFD4E3FF),
    onPrimaryContainer = Color(0xFF001C3A),
    secondary = Color(0xFF0C58C8);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF005FAE),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD4E3FF),
  onPrimaryContainer: Color(0xFF001C3A),
  secondary: Color(0xFF0C58C8),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD9E2FF),
  onSecondaryContainer: Color(0xFF001945),
  tertiary: Color(0xFF006493),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFCAE6FF),
  onTertiaryContainer: Color(0xFF001E2F),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFDFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFE0E2EC),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF74777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFFA5C8FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF005FAE),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA5C8FF),
  onPrimary: Color(0xFF00315E),
  primaryContainer: Color(0xFF004785),
  onPrimaryContainer: Color(0xFFD4E3FF),
  secondary: Color(0xFFB0C6FF),
  onSecondary: Color(0xFF002D6F),
  secondaryContainer: Color(0xFF00429C),
  onSecondaryContainer: Color(0xFFD9E2FF),
  tertiary: Color(0xFF8CCDFF),
  onTertiary: Color(0xFF00344E),
  tertiaryContainer: Color(0xFF004B70),
  onTertiaryContainer: Color(0xFFCAE6FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE3E2E6),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE3E2E6),
  inversePrimary: Color(0xFF005FAE),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA5C8FF),
);

ThemeData themeData(bool isDarkTheme, BuildContext context) {
  return ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          (isDarkTheme) ? darkColorScheme.surface : lightColorScheme.surface,
    ),
    fontFamily: "SM",
    textTheme: TextTheme(
      headline4: TextStyle(
        fontFamily: 'SM',
        fontSize: 18,
        //color: Colors.white,
      ),
    ),
    iconTheme:
        IconThemeData(color: (isDarkTheme) ? Colors.white : Colors.black),
    colorScheme: (isDarkTheme) ? darkColorScheme : lightColorScheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: (isDarkTheme) ? Colors.black : primary),
  );
}
