import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTime provideCurrentDate() => DateTime.now();

  TimeOfDay provideCurrentTime() => TimeOfDay.now();

  DateTime setDateFromMilliseconds(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  DateTime provideFocusedDayForCalendar() {
    final currentDate = provideCurrentDate();
    return DateTime.utc(currentDate.year, currentDate.month, currentDate.day);
  }

  DateTime provideFirstDayForCalendar() => DateTime.utc(2023, 1, 1);

  DateTime provideLastDayForCalendar() => provideFocusedDayForCalendar();

  bool isSameGivenDateFromMillisecondsDate(DateTime date, int milliseconds) {
    final dateFromMillis = setDateFromMilliseconds(milliseconds);
    if (date.day == dateFromMillis.day
        && date.month == dateFromMillis.month
        && date.year == dateFromMillis.year
    ) {
      return true;
    } else {
      return false;
    }
  }

  String formatSelectedEventDate(int date, String locale) {
    final dateTime = setDateFromMilliseconds(date);
    final formatted = DateFormat.MMMMd(locale).format(dateTime);
    return '$formatted, ${dateTime.year}. ${formatHourMinuteTime(date)}';
  }

  String formatSelectedEventDateOnlyDay(int date, String locale) {
    final dateTime = setDateFromMilliseconds(date);
    final formatted = DateFormat.MMMMd(locale).format(dateTime);
    return '$formatted, ${dateTime.year}';
  }

  String formatDayMonthYearDate(int date) => DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(date));
  String formatHourMinuteTime(int date) => DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(date));
  String formatHourMinuteFromTimeOfDay(BuildContext context, TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return '';
    return MaterialLocalizations.of(context).formatTimeOfDay(timeOfDay, alwaysUse24HourFormat: true);
  }

  int getMillisecondsFromHourAndMinute(int hours, int minutes) => hours*60*60*1000 + minutes*60*1000;

  String formatHourMinuteFromInt(int time, String hoursString, String minutesString) {
    final hours = getHoursFromMilliseconds(time);
    final minutes = getMinutesFromMilliseconds(time);

    return '$hours $hoursString, $minutes $minutesString';
  }

  int getHoursFromMilliseconds(int millis) => millis ~/ 3600000;
  int getMinutesFromMilliseconds(int millis) => ((millis - getHoursFromMilliseconds(millis) * 3600000)) ~/ 60000;
  bool isSameDay(DateTime dateTime1, DateTime dateTime2) =>
      (dateTime1.day == dateTime2.day) &&
          (dateTime1.month == dateTime2.month) &&
          (dateTime1.year == dateTime2.year);

  int getTimeInMillisecondsFromHourMinutes(int hour, int minutes) {
    final currentDate = provideCurrentDate();
    final eventDate = currentDate.copyWith(hour: hour, minute: minutes);
    return eventDate.millisecondsSinceEpoch;
  }

  DateTime getDateAtMidnight(int date) => setDateFromMilliseconds(date).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
}