import 'package:terapiasdaluna/domain/interactor/foodevents/edit_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/repository/foodevents/food_events_repository.dart';

class EditFoodEventInteractorImpl extends EditFoodEventInteractor {
  final FoodEventsRepository foodEventsRepository;

  EditFoodEventInteractorImpl({required this.foodEventsRepository});

  @override
  void execute(FoodEvent foodEvent, Function onFinish) async => await foodEventsRepository.editFoodEvent(foodEvent, onFinish);

}