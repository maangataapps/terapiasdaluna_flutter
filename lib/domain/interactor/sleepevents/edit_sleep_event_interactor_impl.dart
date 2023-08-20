import 'package:terapiasdaluna/domain/interactor/sleepevents/edit_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';

class EditSleepEventInteractorImpl extends EditSleepEventInteractor {
  final SleepEventsRepository sleepEventsRepository;

  EditSleepEventInteractorImpl({required this.sleepEventsRepository});

  @override
  void execute(SleepEvent sleepEvent, Function onFinish) async => await sleepEventsRepository.editSleepEvent(sleepEvent, onFinish);

}