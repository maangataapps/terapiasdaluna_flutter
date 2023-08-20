import 'package:terapiasdaluna/domain/interactor/sportevents/edit_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';

class EditSportEventInteractorImpl extends EditSportEventInteractor {
  final SportEventsRepository sportEventsRepository;

  EditSportEventInteractorImpl({required this.sportEventsRepository});

  @override
  void execute(SportEvent sportEvent, Function onFinish) async => await sportEventsRepository.editSportEvent(sportEvent, onFinish);

}