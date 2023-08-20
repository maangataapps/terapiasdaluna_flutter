import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

abstract class DeleteFoodEventInteractor {
  Future<void> execute(FoodEvent foodEvent);
}