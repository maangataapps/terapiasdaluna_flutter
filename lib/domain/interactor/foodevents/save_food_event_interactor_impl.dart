import 'package:terapiasdaluna/domain/interactor/foodevents/save_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';

class SaveFoodEventInteractorImpl extends SaveFoodEventInteractor {
  final FoodEventsRepository foodEventsRepository;

  SaveFoodEventInteractorImpl({required this.foodEventsRepository});

  @override
  void execute(FoodEvent foodEvent, Function onFinish) async => await foodEventsRepository.saveFoodEvent(foodEvent, onFinish);

}