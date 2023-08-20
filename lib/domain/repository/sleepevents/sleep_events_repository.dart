import 'dart:async';

import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

abstract class SleepEventsRepository extends EventsRepositoryImpl {
  Future<void> listenToSleepEvents(String userId, StreamSink<List<SleepEvent>> streamSink);
  Future<void> saveSleepEvent(SleepEvent sleepEvent, Function onFinish);
  Future<void> deleteSleepEvent(SleepEvent sleepEvent);
  Future<void> editSleepEvent(SleepEvent sleepEvent, Function onFinish);
}