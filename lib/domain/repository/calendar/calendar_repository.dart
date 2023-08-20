import 'dart:async';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

abstract class CalendarRepository {
  Future<void> listenToCalendarEvents(String userId, StreamSink<List<CalendarEvent>> streamSink);
  Future<void> filterCalendarEventsByDate(String userId, StreamSink<List<CalendarEvent>> streamSink, DateTime dateTime);
  Future<List<CalendarEvent>> getTotalEvents(String userId);
}