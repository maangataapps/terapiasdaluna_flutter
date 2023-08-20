import 'dart:async';
import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

abstract class SportEventsRepository extends EventsRepositoryImpl {
  Future<void> listenToSportEvents(String userId, StreamSink<List<SportEvent>> streamSink);
  Future<void> saveSportEvent(SportEvent sportEvent, Function onFinish);
  Future<void> deleteSportEvent(SportEvent sportEvent);
  Future<void> editSportEvent(SportEvent sportEvent, Function onFinish);
}