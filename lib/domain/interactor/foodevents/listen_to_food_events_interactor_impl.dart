import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/foodevents/listen_to_food_events_interactor.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';

class ListenToFoodEventsInteractorImpl extends ListenToFoodEventsInteractor {
  final FoodEventsRepository foodEventsRepository;

  ListenToFoodEventsInteractorImpl({required this.foodEventsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<FoodEvent>> streamSink) => foodEventsRepository.listenToFoodEvents(userId, streamSink);

}