import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/poopevents/delete_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/edit_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/listen_to_poop_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/save_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_actions.dart';
import 'package:terapiasdaluna/presentation/poopevents/bloc/poop_events_state.dart';

class PoopEventsBloc extends BaseBloc<PoopEventsActions, PoopEventsState> {
  final ListenToPoopEventsInteractor listenToPoopEventsInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final SavePoopEventInteractor savePoopEventInteractor;
  final DeletePoopEventInteractor deletePoopEventInteractor;
  final EditPoopEventInteractor editPoopEventInteractor;
  final StreamController<List<PoopEvent>> _streamController = StreamController<List<PoopEvent>>.broadcast();
  late Stream<List<PoopEvent>> streamStream = _streamController.stream;

  PoopEventsBloc({
    required this.listenToPoopEventsInteractor,
    required this.getUserIdInteractor,
    required this.savePoopEventInteractor,
    required this.deletePoopEventInteractor,
    required this.editPoopEventInteractor,
  }) : super(PoopEventsState(isLoading: false, onError: null)) {
    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final userId = getUserIdInteractor.execute();
      await listenToPoopEventsInteractor.execute(userId, _streamController.sink);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SavePoopEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final poopEvent = PoopEvent(
        userId: getUserIdInteractor.execute(),
        eventId: getEventId(),
        eventDate: event.eventDate,
        poopType: event.poopType,
        abdominalPain: event.abdominalPain,
        flatulence: event.flatulence,
      );
      savePoopEventInteractor.execute(poopEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<EditPoopEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));

      final poopEvent = PoopEvent(
        userId: getUserIdInteractor.execute(),
        eventId: event.eventId,
        eventDate: event.eventDate,
        poopType: event.poopType,
        abdominalPain: event.abdominalPain,
        flatulence: event.flatulence,
      );

      // TODO: hacer bien el manejo de errores.
      try {
        editPoopEventInteractor.execute(poopEvent, event.onFinish);
        emit(state.copyWith(isLoading: false, onError: null));
      } catch (e) {
        emit(state.copyWith(isLoading: false, onError: null));
      }
    });

    on<DeletePoopEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await deletePoopEventInteractor.execute(event.poopEvent);

      emit(state.copyWith(isLoading: false, onError: null));
    });
  }

}