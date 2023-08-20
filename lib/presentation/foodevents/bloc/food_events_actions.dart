import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

class FoodEventsActions {
  FoodEventsActions();
}

class InitializeStateAction extends FoodEventsActions {
  InitializeStateAction();
}

class SaveFoodEventAction extends FoodEventsActions {
  final String foodInfo;
  final int eventDate;
  final Function onFinish;

  SaveFoodEventAction({required this.foodInfo, required this.eventDate, required this.onFinish});
}

class DeleteFoodEventAction extends FoodEventsActions {
  final FoodEvent foodEvent;

  DeleteFoodEventAction({required this.foodEvent});
}

class EditFoodEventAction extends FoodEventsActions {
  final String eventId;
  final String foodInfo;
  final int eventDate;
  final Function onFinish;

  EditFoodEventAction({required this.eventId, required this.foodInfo, required this.eventDate, required this.onFinish});
}