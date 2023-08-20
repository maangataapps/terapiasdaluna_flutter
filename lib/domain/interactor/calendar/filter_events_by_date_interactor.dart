import 'dart:async';

import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

abstract class FilterEventsByDateInteractor {
  Future<void> execute(String userId, StreamSink<List<CalendarEvent>> streamSink, DateTime dateTime);
}