import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/foodevents/delete_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/edit_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/listen_to_food_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/save_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_actions.dart';
import 'package:terapiasdaluna/presentation/foodevents/bloc/food_events_state.dart';

class FoodEventsBloc extends BaseBloc<FoodEventsActions, FoodEventsState> {
  final ListenToFoodEventsInteractor listenToFoodEventsInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final SaveFoodEventInteractor saveFoodEventInteractor;
  final DeleteFoodEventInteractor deleteFoodEventInteractor;
  final EditFoodEventInteractor editFoodEventInteractor;
  final StreamController<List<FoodEvent>> _streamController = StreamController<List<FoodEvent>>.broadcast();
  late Stream<List<FoodEvent>> streamStream = _streamController.stream;

  FoodEventsBloc({
    required this.listenToFoodEventsInteractor,
    required this.getUserIdInteractor,
    required this.saveFoodEventInteractor,
    required this.deleteFoodEventInteractor,
    required this.editFoodEventInteractor,
  }) : super(FoodEventsState(
    isLoading: false,
    onError: null,
  ),) {

    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      final userId = getUserIdInteractor.execute();
      await listenToFoodEventsInteractor.execute(userId, _streamController.sink);
      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveFoodEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final foodEvent = FoodEvent(
        eventId: getEventIdFromDate(),
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        foodInfo: event.foodInfo,
      );
      saveFoodEventInteractor.execute(foodEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<DeleteFoodEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await deleteFoodEventInteractor.execute(event.foodEvent);
    });

    on<EditFoodEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final foodEvent = FoodEvent(
        eventId: event.eventId,
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        foodInfo: event.foodInfo,
      );
      editFoodEventInteractor.execute(foodEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

}