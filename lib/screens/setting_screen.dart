import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen(this.isDark, {super.key});
  bool isDark;
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(),
      child: Switch(
          value: widget.isDark,
          onChanged: (value) {
            setState(() {
              widget.isDark = !widget.isDark;
            });
          }),
    );
  }
}
