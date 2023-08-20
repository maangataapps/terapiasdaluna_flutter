import 'dart:async';

import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

abstract class ListenToFoodEventsInteractor {
  Future<void> execute(String userId, StreamSink<List<FoodEvent>> streamSink);
}