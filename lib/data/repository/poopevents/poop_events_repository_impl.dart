import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/repository/poopevents/poop_events_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class PoopEventsRepositoryImpl extends PoopEventsRepository {
  final FirebaseDatabase firebaseDatabase;
  final EventsHelper _eventsHelper = EventsHelper();
  final List<PoopEvent> _poopEvents = [];

  PoopEventsRepositoryImpl({
    required this.firebaseDatabase,
  });

  @override
  Future<void> deletePoopEvent(PoopEvent poopEvent) async {
    deleteEvent(firebaseDatabase, constants.poopEvents, poopEvent.userId, constants.eventId, poopEvent.eventId);
  }

  @override
  Future<void> editPoopEvent(PoopEvent poopEvent, Function onFinish) async {
    editEvent(firebaseDatabase, poopEvent.userId, constants.poopEvents, constants.eventId, poopEvent.eventId, poopEvent.toJson(), onFinish);
  }

  @override
  Future<void> listenToPoopEvents(String userId, StreamSink<List<PoopEvent>> streamSink) async {
    var poopEventsRef = firebaseDatabase.ref('${constants.poopEvents}/$userId');
    _eventsHelper.listenToPoopEvents(
      poopEventsRef,
      _poopEvents,
      () => streamSink.add(_poopEvents.reversed.toList()),
      true,
    );
  }

  @override
  Future<void> savePoopEvent(PoopEvent poopEvent, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.poopEvents, poopEvent.userId, poopEvent.toJson(), onFinish);
  }
  
}