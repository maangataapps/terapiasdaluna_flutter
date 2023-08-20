import 'dart:async';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

abstract class ListenToSleepEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<SleepEvent>> streamSink);
}