import 'package:terapiasdaluna/domain/interactor/sleepevents/delete_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';

class DeleteSleepEventInteractorImpl extends DeleteSleepEventInteractor {
  final SleepEventsRepository sleepEventsRepository;

  DeleteSleepEventInteractorImpl({required this.sleepEventsRepository});

  @override
  Future<void> execute(SleepEvent sleepEvent) async => await sleepEventsRepository.deleteSleepEvent(sleepEvent);
}