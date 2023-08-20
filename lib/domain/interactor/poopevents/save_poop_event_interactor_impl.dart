import 'package:terapiasdaluna/domain/interactor/poopevents/save_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';

class SavePoopEventInteractorImpl extends SavePoopEventInteractor {
  final PoopEventsRepository poopEventsRepository;

  SavePoopEventInteractorImpl({required this.poopEventsRepository});

  @override
  void execute(PoopEvent poopEvent, Function onFinish) async => await poopEventsRepository.savePoopEvent(poopEvent, onFinish);

}