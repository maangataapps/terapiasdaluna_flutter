import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';

abstract class EditFoodEventInteractor {
  void execute(FoodEvent foodEvent, Function onFinish);
}