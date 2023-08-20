import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

abstract class SavePoopEventInteractor {
  void execute(PoopEvent poopEvent, Function onFinish);
}