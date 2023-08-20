import 'dart:async';

import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

abstract class ListenToSportEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<SportEvent>> streamSink);
}