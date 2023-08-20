import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

abstract class EditPoopEventInteractor {
  void execute(PoopEvent poopEvent, Function onFinish);
}