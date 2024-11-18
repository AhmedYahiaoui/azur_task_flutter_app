import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Turns ‘TimeOfDay‘ to ‘DateTime‘
extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

/// Calendar config for ‘CalendarStyle‘ and ‘HeaderStyle‘
CalendarStyle calendarStyle = const CalendarStyle(
  todayDecoration: BoxDecoration(
    color: Colors.lightBlueAccent,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  ),
  selectedDecoration: BoxDecoration(
    color: Colors.blue,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  ),
  defaultDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  ),
  markersMaxCount: 8, // No dots in this view
);

HeaderStyle headerStyle = const HeaderStyle(
  formatButtonVisible: false,
  titleCentered: true,
);
