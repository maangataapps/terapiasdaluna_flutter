import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/calendar/listen_to_calendar_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/repository/calendar/calendar_repository.dart';

class ListenToCalendarEventsInteractorImpl extends ListenToCalendarEventsInteractor {
  final CalendarRepository calendarRepository;

  ListenToCalendarEventsInteractorImpl({required this.calendarRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<CalendarEvent>> streamSink) => calendarRepository.listenToCalendarEvents(userId, streamSink);

}