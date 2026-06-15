import 'package:boom_signup/models/event.dart';

class EventHandler {
  static DateTime getNextWeekday(Weekday target) {
    int addNum;
    switch (target) {
      case Weekday.monday:
        addNum = 1;
        break;
      case Weekday.tuesday:
        addNum = 2;
        break;
      case Weekday.wednesday:
        addNum = 3;
        break;
      case Weekday.thursday:
        addNum = 4;
        break;
      case Weekday.friday:
        addNum = 5;
        break;
      case Weekday.saturday:
        addNum = 6;
        break;
      case Weekday.sunday:
        addNum = 7;
        break;
    }
    int currentWeekday = DateTime.now().weekday;
    int daysUntil = (addNum - currentWeekday + 7) % 7;
    DateTime targetDay = DateTime.now().add(Duration(days: daysUntil));
    targetDay = DateTime(targetDay.year, targetDay.month, targetDay.day);
    return targetDay;
  }

  static Event? fetchWeekdayEvent(List<Event> events, Weekday target) {
    DateTime targetDay = getNextWeekday(target);
    for (Event event in events) {
      if (targetDay == event.date) {
        return event;
      }
    }
    return null;
  }
}

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
