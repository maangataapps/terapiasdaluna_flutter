import 'dart:async';

import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

abstract class FoodEventsRepository extends EventsRepositoryImpl {
  Future<void> listenToFoodEvents(String userId, StreamSink<List<FoodEvent>> streamSink);
  Future<void> saveFoodEvent(FoodEvent foodEvent, Function onFinish);
  Future<void> deleteFoodEvent(FoodEvent foodEvent);
  Future<void> editFoodEvent(FoodEvent foodEvent, Function onFinish);
}