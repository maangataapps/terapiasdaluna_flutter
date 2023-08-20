import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

abstract class SaveFoodEventInteractor {
  void execute(FoodEvent foodEvent, Function onFinish);
}