import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

abstract class GetTotalEventsInteractor {
  Future<List<CalendarEvent>> execute(String userId);
}