import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

abstract class DeleteSleepEventInteractor {
  Future<void> execute(SleepEvent sleepEvent);
}