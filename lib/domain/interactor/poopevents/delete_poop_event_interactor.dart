import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

abstract class DeletePoopEventInteractor {
  Future<void> execute(PoopEvent poopEvent);
}