import 'package:flutter/material.dart';
import '../data/shared_pref.dart';
import '/theme/Themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   late ThemeData _selectedTheme;
//   late SharedPreferences prefs;
//   ThemeProvider({bool isDark: false}) {
//     this._selectedTheme = isDark ? darkTheme : lightTheme;
//   }

//   ThemeData get getTheme => _selectedTheme;

//   Future<void> changeTheme() async {
//     prefs = await SharedPreferences.getInstance();

//     if (_selectedTheme == darkTheme) {
//       _selectedTheme = lightTheme;
//       await prefs.setBool("isDark", false);
//     } else {
//       _selectedTheme = darkTheme;
//       await prefs.setBool("isDark", true);
//     }
// //notifying all the listeners(consumers) about the change.
//     notifyListeners();
//   }
// }
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}