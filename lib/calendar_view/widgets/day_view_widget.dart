import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:note_application/screens/feature_screen.dart';

import '../model/event.dart';

class DayViewWidget extends StatelessWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;

  const DayViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayView<Event>(
      key: state,
      width: width,
      headerStyle: HeaderStyle(
        titleAlign: TextAlign.end,
        leftIconVisible: true,
        rightIconVisible: false,
        leftIcon: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return featureScreen();
              }),
            );
          },
          child: Icon(
            Icons.arrow_back,
            size: 33,
            color: Theme.of(context).brightness == Brightness.dark
                ? Color.fromARGB(250, 214, 213, 213)
                : Color.fromARGB(255, 25, 25, 25),
          ),
        ),
        // headerMargin: EdgeInsets.only(top: 10),
        headerTextStyle: TextStyle(
          fontSize: 20,
          color: Theme.of(context).brightness == Brightness.light
              ? Color.fromARGB(255, 25, 25, 25)
              : Colors.white,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromARGB(255, 25, 25, 25)
              : Color.fromARGB(250, 214, 213, 213),
        ),
      ),

      verticalLineOffset: 0,
      safeAreaOption: SafeAreaOption(
        top: false,
        bottom: false,
        right: false,
        left: false,
        maintainBottomViewPadding: false,
      ),
      //showHalfHours: true,
      heightPerMinute: 2,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromARGB(255, 25, 25, 25)
          : Color.fromARGB(250, 214, 213, 213),
      timeLineBuilder: _timeLineBuilder,
// dayDetectorBuilder: ({date, height, heightPerMinute, minuteSlotSize, width}) => ,
      hourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).brightness == Brightness.dark
            ? Color.fromARGB(250, 214, 213, 213)
            : Color.fromARGB(255, 25, 25, 25),
      ),
      // halfHourIndicatorSettings: HourIndicatorSettings(
      //   color: Theme.of(context).dividerColor,
      //   lineStyle: LineStyle.dashed,
      // ),
    );
  }

  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
