import 'package:terapiasdaluna/domain/interactor/foodevents/delete_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';

class DeleteFoodEventInteractorImpl extends DeleteFoodEventInteractor {
  final FoodEventsRepository foodEventsRepository;

  DeleteFoodEventInteractorImpl({required this.foodEventsRepository});

  @override
  Future<void> execute(FoodEvent foodEvent) async => await foodEventsRepository.deleteFoodEvent(foodEvent);
}