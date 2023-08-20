import 'package:terapiasdaluna/domain/interactor/calendar/get_total_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/repository/calendar/calendar_repository.dart';

class GetTotalEventsInteractorImpl extends GetTotalEventsInteractor {
  final CalendarRepository calendarRepository;

  GetTotalEventsInteractorImpl({required this.calendarRepository});

  @override
  Future<List<CalendarEvent>> execute(String userId) => calendarRepository.getTotalEvents(userId);

}