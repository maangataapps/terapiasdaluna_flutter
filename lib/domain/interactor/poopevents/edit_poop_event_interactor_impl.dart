import 'package:terapiasdaluna/domain/interactor/poopevents/edit_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';

class EditPoopEventInteractorImpl extends EditPoopEventInteractor {
  final PoopEventsRepository poopEventsRepository;

  EditPoopEventInteractorImpl({required this.poopEventsRepository});

  @override
  void execute(PoopEvent poopEvent, Function onFinish) async => await poopEventsRepository.editPoopEvent(poopEvent, onFinish);

}