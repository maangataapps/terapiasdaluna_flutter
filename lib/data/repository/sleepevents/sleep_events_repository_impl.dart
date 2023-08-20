import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/repository/sleepevents/sleep_events_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class SleepEventsRepositoryImpl extends SleepEventsRepository {
  final FirebaseDatabase firebaseDatabase;
  final EventsHelper _eventsHelper = EventsHelper();
  final List<SleepEvent> _sleepEvents = [];

  SleepEventsRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<void> listenToSleepEvents(String userId, StreamSink<List<SleepEvent>> streamSink) async {
      var sleepEventsRef = firebaseDatabase.ref('${constants.sleepEvents}/$userId');
      _eventsHelper.listenToSleepEvents(
        sleepEventsRef,
        _sleepEvents,
        () => streamSink.add(_sleepEvents.reversed.toList()),
        true,
      );
  }

  @override
  Future<void> deleteSleepEvent(SleepEvent sleepEvent) async {
    deleteEvent(firebaseDatabase, constants.sleepEvents, sleepEvent.userId, constants.eventId, sleepEvent.eventId);
  }

  @override
  Future<void> editSleepEvent(SleepEvent sleepEvent, Function onFinish) async {
    editEvent(firebaseDatabase, sleepEvent.userId, constants.sleepEvents, constants.eventId, sleepEvent.eventId, sleepEvent.toJson(), onFinish);
  }

  @override
  Future<void> saveSleepEvent(SleepEvent sleepEvent, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.sleepEvents, sleepEvent.userId, sleepEvent.toJson(), onFinish);
  }
  
}