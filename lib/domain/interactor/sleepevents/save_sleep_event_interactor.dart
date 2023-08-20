import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

abstract class SaveSleepEventInteractor {
  void execute(SleepEvent sleepEvent, Function onFinish);
}