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
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        primary: true,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(255, 94, 92, 92)
                      : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
