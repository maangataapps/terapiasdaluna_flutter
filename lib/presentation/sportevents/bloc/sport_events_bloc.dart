import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/sportevents/delete_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/edit_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/listen_to_sport_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/save_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_actions.dart';
import 'package:terapiasdaluna/presentation/sportevents/bloc/sport_events_state.dart';

class SportEventsBloc extends BaseBloc<SportEventsActions, SportEventsState> {
  final ListenToSportEventsInteractor listenToSportEventsInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final SaveSportEventInteractor saveSportEventInteractor;
  final DeleteSportEventInteractor deleteSportEventInteractor;
  final EditSportEventInteractor editSportEventInteractor;
  final StreamController<List<SportEvent>> _streamController = StreamController<List<SportEvent>>.broadcast();
  late Stream<List<SportEvent>> streamStream = _streamController.stream;

  SportEventsBloc({
    required this.listenToSportEventsInteractor,
    required this.getUserIdInteractor,
    required this.saveSportEventInteractor,
    required this.deleteSportEventInteractor,
    required this.editSportEventInteractor,
  }) : super(SportEventsState(isLoading: false, onError: null)) {

    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      final userId = getUserIdInteractor.execute();
      await listenToSportEventsInteractor.execute(userId, _streamController.sink);
      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SaveSportEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final sportEvent = SportEvent(
        eventId: getEventIdFromDate(),
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        sportInfo: event.sportInfo,
        duration: event.duration,
      );
      saveSportEventInteractor.execute(sportEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<DeleteSportEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      await deleteSportEventInteractor.execute(event.sportEvent);
    });

    on<EditSportEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));

      final sportEvent = SportEvent(
        eventId: event.eventId,
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        sportInfo: event.sportInfo,
        duration: event.duration,
      );
      editSportEventInteractor.execute(sportEvent, event.onFinish);

      emit(state.copyWith(isLoading: false, onError: null));
    });

  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

}