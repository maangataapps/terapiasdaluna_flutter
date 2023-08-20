import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

abstract class EditSleepEventInteractor {
  void execute(SleepEvent sleepEvent, Function onFinish);
}