import 'package:terapiasdaluna/domain/interactor/sportevents/save_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';

class SaveSportEventInteractorImpl extends SaveSportEventInteractor {
  final SportEventsRepository sportEventsRepository;

  SaveSportEventInteractorImpl({required this.sportEventsRepository});

  @override
  void execute(SportEvent sportEvent, Function onFinish) async => await sportEventsRepository.saveSportEvent(sportEvent, onFinish);

}