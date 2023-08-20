import 'package:terapiasdaluna/domain/interactor/sportevents/delete_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';

class DeleteSportEventInteractorImpl extends DeleteSportEventInteractor {
  final SportEventsRepository sportEventsRepository;

  DeleteSportEventInteractorImpl({required this.sportEventsRepository});

  @override
  Future<void> execute(SportEvent sportEvent) async => await sportEventsRepository.deleteSportEvent(sportEvent);
}