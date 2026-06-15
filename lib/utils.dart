import 'package:boom_signup/database/event_handler.dart';
import 'package:boom_signup/models/event.dart';

Weekday dateToWeekday(DateTime day) {
  const weekdayNames = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday,
  ];

  int weekday = day.weekday;

  return weekdayNames[weekday - 1];
}

String weekdayToString(Weekday day) {
  switch (day) {
    case Weekday.monday:
      return "Monday";
    case Weekday.tuesday:
      return "Tuesday";
    case Weekday.wednesday:
      return "Wednesday";
    case Weekday.thursday:
      return "Thursday";
    case Weekday.friday:
      return "Friday";
    case Weekday.saturday:
      return "Saturday";
    case Weekday.sunday:
      return "Sunday";
  }
}

int sortEventsWithTodayFirst(Event a, Event b) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  int da = a.date.difference(today).inDays;
  int db = b.date.difference(today).inDays;

  if (da < 0) da += 7;
  if (db < 0) db += 7;

  return da.compareTo(db);
}
