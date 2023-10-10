import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/supplements/delete_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/edit_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplement_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplements_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/supplements/save_supplement_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_actions.dart';
import 'package:terapiasdaluna/presentation/supplements/bloc/supplements_state.dart';

class SupplementsBloc extends BaseBloc<SupplementsActions, SupplementsState> {
  final GetUserIdInteractor getUserIdInteractor;
  final SaveSupplementInteractor saveSupplementInteractor;
  final ListenToSupplementsInteractor listenToSupplementsInteractor;
  final SaveSupplementEventInteractor saveSupplementEventInteractor;
  final ListenToSupplementEventsInteractor listenToSupplementEventsInteractor;
  final EditSupplementInteractor editSupplementInteractor;
  final EditSupplementEventInteractor editSupplementEventInteractor;
  final DeleteSupplementEventInteractor deleteSupplementEventInteractor;

  final StreamController<List<Supplement>> _streamController = StreamController<List<Supplement>>.broadcast();
  late Stream<List<Supplement>> streamStream = _streamController.stream;

  final StreamController<List<SupplementEvent>> _streamEventsController = StreamController<List<SupplementEvent>>.broadcast();
  late Stream<List<SupplementEvent>> streamEventsStream = _streamEventsController.stream;


  SupplementsBloc({
    required this.getUserIdInteractor,
    required this.saveSupplementInteractor,
    required this.listenToSupplementsInteractor,
    required this.saveSupplementEventInteractor,
    required this.listenToSupplementEventsInteractor,
    required this.editSupplementInteractor,
    required this.editSupplementEventInteractor,
    required this.deleteSupplementEventInteractor,
  }) : super(SupplementsState(
    isLoading: false,
    onError: null,
    totalSupplements: [],
  ),) {

    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final userId = getUserIdInteractor.execute();
      await listenToSupplementsInteractor.execute(userId, _streamController.sink);
      await listenToSupplementEventsInteractor.execute(userId, _streamEventsController.sink);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveSupplementAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      final supplement = event.supplement;
      supplement.userId = getUserIdInteractor.execute();

      saveSupplementInteractor.execute(supplement, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<EditSupplementAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final supplement = event.supplement;
      supplement.userId = getUserIdInteractor.execute();
      editSupplementInteractor.execute(supplement, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<ChangeSupplementActivationStateAction>((event, emit) {
      final supplement = event.supplement;
      supplement.isActivated = event.isActivated;
      supplement.userId = getUserIdInteractor.execute();
      editSupplementInteractor.execute(supplement, () {});

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveSupplementEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final supplementEvent = SupplementEvent(
        eventId: getEventId(),
        supplementId: event.supplement.id,
        userId: getUserIdInteractor.execute(),
        name: event.supplement.name,
        intakeTime: event.chosenDate.millisecondsSinceEpoch,
        outOfMeals: event.supplement.outOfMeals,
      );
      supplementEvent.userId = getUserIdInteractor.execute();
      saveSupplementEventInteractor.execute(supplementEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<EditSupplementEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final supplementEvent = SupplementEvent(
        eventId: event.eventId!,
        supplementId: event.supplement.id,
        userId: getUserIdInteractor.execute(),
        name: event.supplement.name,
        intakeTime: event.chosenDate.millisecondsSinceEpoch,
        outOfMeals: event.supplement.outOfMeals,
      );
      editSupplementEventInteractor.execute(supplementEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<DeleteSupplementEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await deleteSupplementEventInteractor.execute(event.supplementEvent);

      emit(state.copyWith(isLoading: false, onError: null));
    });

  }

}