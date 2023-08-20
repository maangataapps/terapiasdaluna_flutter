import 'dart:async';

import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

abstract class PoopEventsRepository extends EventsRepositoryImpl {
  Future<void> listenToPoopEvents(String userId, StreamSink<List<PoopEvent>> streamSink);
  Future<void> savePoopEvent(PoopEvent poopEvent, Function onFinish);
  Future<void> deletePoopEvent(PoopEvent poopEvent);
  Future<void> editPoopEvent(PoopEvent poopEvent, Function onFinish);
}