import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerDialog extends StatefulWidget {
  final Function(DateTime) onSave;

  TimePickerDialog({required this.onSave});

  @override
  _TimePickerDialogState createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  late TimeOfDay _time;

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Select time:'),
          SizedBox(width: 8.0),
          InkWell(
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                setState(() {
                  _time = selectedTime;
                });
              }
            },
            child: Text(
              '${_time.format(context)}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('SAVE'),
          onPressed: () {
            final selectedDateTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              _time.hour,
              _time.minute,
            );
            widget.onSave(selectedDateTime);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
