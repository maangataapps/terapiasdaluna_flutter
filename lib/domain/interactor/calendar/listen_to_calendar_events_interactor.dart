import 'dart:async';

import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

abstract class ListenToCalendarEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<CalendarEvent>> streamSink);
}