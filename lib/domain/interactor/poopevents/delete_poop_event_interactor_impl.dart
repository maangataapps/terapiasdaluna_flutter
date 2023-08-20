import 'package:terapiasdaluna/domain/interactor/poopevents/delete_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';

class DeletePoopEventInteractorImpl extends DeletePoopEventInteractor {
  final PoopEventsRepository poopEventsRepository;

  DeletePoopEventInteractorImpl({required this.poopEventsRepository});

  @override
  Future<void> execute(PoopEvent poopEvent) async => await poopEventsRepository.deletePoopEvent(poopEvent);
}