import 'package:terapiasdaluna/domain/interactor/sleepevents/save_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';

class SaveSleepEventInteractorImpl extends SaveSleepEventInteractor {
  final SleepEventsRepository sleepEventsRepository;

  SaveSleepEventInteractorImpl({required this.sleepEventsRepository});

  @override
  void execute(SleepEvent sleepEvent, Function onFinish) async => await sleepEventsRepository.saveSleepEvent(sleepEvent, onFinish);

}