import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class FoodEventsRepositoryImpl extends FoodEventsRepository {
  final FirebaseDatabase firebaseDatabase;
  final List<FoodEvent> _foodEvents = [];
  final EventsHelper _eventsHelper = EventsHelper();

  FoodEventsRepositoryImpl({
    required this.firebaseDatabase,
  });

  @override
  Future<void> listenToFoodEvents(String userId, StreamSink<List<FoodEvent>> streamSink) async {
    var foodEventsRef = firebaseDatabase.ref('${constants.foodEvents}/$userId');
    _eventsHelper.listenToFoodEvents(
        foodEventsRef,
        _foodEvents,
        () => streamSink.add(_foodEvents.reversed.toList()),
      true,
    );
  }

  @override
  Future<void> saveFoodEvent(FoodEvent foodEvent, Function onFinish) async {
    saveEvent(firebaseDatabase, constants.foodEvents, foodEvent.userId, foodEvent.toJson(), onFinish);
  }

  @override
  Future<void> deleteFoodEvent(FoodEvent foodEvent) async {
    deleteEvent(firebaseDatabase, constants.foodEvents, foodEvent.userId, constants.eventId, foodEvent.eventId);
  }

  @override
  Future<void> editFoodEvent(FoodEvent foodEvent, Function onFinish) async {
    editEvent(firebaseDatabase, foodEvent.userId, constants.foodEvents, constants.eventId, foodEvent.eventId, foodEvent.toJson(), onFinish);
  }

}