import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class SupplementsRepositoryImpl extends SupplementsRepository {
  final FirebaseDatabase firebaseDatabase;
  final List<Supplement> _supplements = [];
  final List<SupplementEvent> _supplementEvents = [];
  final EventsHelper _eventsHelper = EventsHelper();

  SupplementsRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<void> saveSupplement(Supplement supplement, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.supplements, supplement.userId!, supplement.toJson(), onFinish);
  }

  @override
  Future<void> listenToSupplements(String userId, StreamSink<List<Supplement>> streamSink) async {
    var supplementsRef = firebaseDatabase.ref('${constants.supplements}/$userId');
    _eventsHelper.listenToSupplements(
      supplementsRef,
      _supplements,
          () => streamSink.add(_supplements),
      true,
    );
  }

  @override
  Future<void> editSupplement(Supplement supplement, Function onFinish) async {
    editEvent(firebaseDatabase, supplement.userId!, constants.supplements, constants.id, supplement.id, supplement.toJson(), onFinish);
  }

  @override
  Future<void> deleteSupplementEvent(SupplementEvent supplementEvent) async {
    deleteEvent(firebaseDatabase, constants.supplementEvents, supplementEvent.userId, constants.eventId, supplementEvent.eventId);
  }

  @override
  Future<void> editSupplementEvent(SupplementEvent supplementEvent, Function onFinish) async {
    editEvent(firebaseDatabase, supplementEvent.userId, constants.supplementEvents, constants.eventId, supplementEvent.eventId, supplementEvent.toJson(), onFinish);
  }

  @override
  Future<void> listenToSupplementEvents(String userId, StreamSink<List<SupplementEvent>> streamSink) async {
    var supplementEventsRef = firebaseDatabase.ref('${constants.supplementEvents}/$userId');
    _eventsHelper.listenToSupplementEvents(
      supplementEventsRef,
      _supplementEvents,
          () => streamSink.add(_supplementEvents),
      true,
    );
  }

  @override
  Future<void> saveSupplementEvent(SupplementEvent supplementEvent, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.supplementEvents, supplementEvent.userId, supplementEvent.toJson(), onFinish);
  }

}