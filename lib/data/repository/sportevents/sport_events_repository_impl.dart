import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/repository/sportevents/sport_events_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class SportEventsRepositoryImpl extends SportEventsRepository {
  final FirebaseDatabase firebaseDatabase;
  final List<SportEvent> _sportEvents = [];
  final EventsHelper _eventsHelper = EventsHelper();

  SportEventsRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<void> deleteSportEvent(SportEvent sportEvent) async {
    deleteEvent(firebaseDatabase, constants.sportEvents, sportEvent.userId, constants.eventId, sportEvent.eventId);
  }

  @override
  Future<void> editSportEvent(SportEvent sportEvent, Function onFinish) async {
    editEvent(firebaseDatabase, sportEvent.userId, constants.sportEvents, constants.eventId, sportEvent.eventId, sportEvent.toJson(), onFinish);
  }

  @override
  Future<void> listenToSportEvents(String userId, StreamSink<List<SportEvent>> streamSink) async {
    var sportEventsRef = firebaseDatabase.ref('${constants.sportEvents}/$userId');
    _eventsHelper.listenToSportEvents(
      sportEventsRef,
      _sportEvents,
          () => streamSink.add(_sportEvents),
      true,
    );
  }

  @override
  Future<void> saveSportEvent(SportEvent sportEvent, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.sportEvents, sportEvent.userId, sportEvent.toJson(), onFinish);
  }

}