import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:note_application/calendar_view/extension.dart';
import 'package:note_application/theme/color_schemes.g.dart';
import 'package:provider/provider.dart';

import '../calendar_view/day_view_screen.dart';
import '../calendar_view/model/event.dart';
import '../calendar_view/pages/month_view_page.dart';
import '../calendar_view/widgets/responsive_widget.dart';
import '../models/ThemeNotifier.dart';
import '../widgets/cheque_screen.dart';

DateTime get _now => DateTime.now();

class featureScreen extends StatelessWidget {
  featureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<Event>(
      controller: EventController<Event>()..addAll(_events),
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeData(themeProvider.darkTheme, context),
            //title: 'Flutter Calendar Page Demo',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              //appBar: AppBar(),
              body: SeeCalendar(),
            ),
          );
        },
      ),
    );
  }
}

List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event(title: "Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: Event(title: "Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: Event(title: "Sprint Meeting."),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: Event(title: "Team Meeting"),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: Event(title: "Chemistry Viva"),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];

class SeeCalendar extends StatelessWidget {
  const SeeCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'توی اینجا میتونی برنامه روزانه و هفتگی خودتو درست کنی',
            textAlign: TextAlign.center,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushRoute(
                        DayViewPageDemo(),
                      );
                    },
                    child: Text('برنامه روزانه'),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black12,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 25, 25, 25)
                              : Color(0xff18DAA3),
                      minimumSize: Size(320, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () => context.pushRoute(MonthViewPageDemo()),
                      child: Text('برنامه هفتگی'),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black12,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color.fromARGB(255, 25, 25, 25)
                                : Color(0xff18DAA3),
                        minimumSize: Size(320, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromARGB(255, 94, 92, 92)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
