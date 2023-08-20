import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/sleepevents/delete_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/edit_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/listen_to_sleep_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/save_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_actions.dart';
import 'package:terapiasdaluna/presentation/sleepevents/bloc/sleep_events_state.dart';

class SleepEventsBloc extends BaseBloc<SleepEventsActions, SleepEventsState> {
  final ListenToSleepEventsInteractor listenToSleepEventsInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final SaveSleepEventInteractor saveSleepEventInteractor;
  final DeleteSleepEventInteractor deleteSleepEventInteractor;
  final EditSleepEventInteractor editSleepEventInteractor;
  final StreamController<List<SleepEvent>> _streamController = StreamController<List<SleepEvent>>.broadcast();
  late Stream<List<SleepEvent>> streamStream = _streamController.stream;

  SleepEventsBloc({
    required this.listenToSleepEventsInteractor,
    required this.getUserIdInteractor,
    required this.saveSleepEventInteractor,
    required this.deleteSleepEventInteractor,
    required this.editSleepEventInteractor,
  }) : super(SleepEventsState(isLoading: false, onError: null)) {
    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final userId = getUserIdInteractor.execute();
      await listenToSleepEventsInteractor.execute(userId, _streamController.sink);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveSleepEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final sleepEvent = SleepEvent(
        userId: getUserIdInteractor.execute(),
        eventId: getEventIdFromDate(),
        eventDate: event.eventDate,
        quality: event.quality,
        sleepTime: event.sleepTime,
      );
      saveSleepEventInteractor.execute(sleepEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<EditSleepEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final sleepEvent = SleepEvent(
        eventId: event.eventId,
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        quality: event.quality,
        sleepTime: event.sleepTime,
      );

      // TODO: hacer bien el manejo de errores.
      try {
        editSleepEventInteractor.execute(sleepEvent, event.onFinish);
        emit(state.copyWith(isLoading: false, onError: null));
      } catch (e) {
        emit(state.copyWith(isLoading: false, onError: null));
      }
    });

    on<DeleteSleepEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await deleteSleepEventInteractor.execute(event.sleepEvent);

      emit(state.copyWith(isLoading: false, onError: null));
    });

  }

}