import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/calendar/filter_events_by_date_interactor.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/repository/calendar/calendar_repository.dart';

class FilterEventsByDateInteractorImpl extends FilterEventsByDateInteractor {
  final CalendarRepository calendarRepository;

  FilterEventsByDateInteractorImpl({required this.calendarRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<CalendarEvent>> streamSink, DateTime dateTime) => calendarRepository.filterCalendarEventsByDate(userId, streamSink, dateTime);

}