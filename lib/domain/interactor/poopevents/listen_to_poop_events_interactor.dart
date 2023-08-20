import 'dart:async';

import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

abstract class ListenToPoopEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<PoopEvent>> streamSink);
}