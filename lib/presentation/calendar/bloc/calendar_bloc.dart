import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/calendar/filter_events_by_date_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/get_total_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/calendar/listen_to_calendar_events_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/delete_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/foodevents/edit_food_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/delete_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/poopevents/edit_poop_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/delete_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sleepevents/edit_sleep_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/delete_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/sportevents/edit_sport_event_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_actions.dart';
import 'package:terapiasdaluna/presentation/calendar/bloc/calendar_state.dart';

class CalendarBloc extends BaseBloc<CalendarActions, CalendarState> {
  final ListenToCalendarEventsInteractor listenToCalendarEventsInteractor;
  final GetUserIdInteractor getUserIdInteractor;
  final EditFoodEventInteractor editFoodEventInteractor;
  final EditSportEventInteractor editSportEventInteractor;
  final EditSleepEventInteractor editSleepEventInteractor;
  final EditPoopEventInteractor editPoopEventInteractor;
  final DeleteFoodEventInteractor deleteFoodEventInteractor;
  final DeleteSportEventInteractor deleteSportEventInteractor;
  final DeleteSleepEventInteractor deleteSleepEventInteractor;
  final DeletePoopEventInteractor deletePoopEventInteractor;
  final FilterEventsByDateInteractor filterEventsByDateInteractor;
  final GetTotalEventsInteractor getTotalEventsInteractor;
  final StreamController<List<CalendarEvent>> _streamController = StreamController<List<CalendarEvent>>.broadcast();
  late Stream<List<CalendarEvent>> streamStream = _streamController.stream;
  final dateTimeHelper = DateTimeHelper();

  CalendarBloc({
    required this.listenToCalendarEventsInteractor,
    required this.getUserIdInteractor,
    required this.editFoodEventInteractor,
    required this.editSportEventInteractor,
    required this.editSleepEventInteractor,
    required this.editPoopEventInteractor,
    required this.deleteFoodEventInteractor,
    required this.deleteSportEventInteractor,
    required this.deleteSleepEventInteractor,
    required this.deletePoopEventInteractor,
    required this.filterEventsByDateInteractor,
    required this.getTotalEventsInteractor,
  }) : super(CalendarState(isLoading: false,),) {

    on<InitializeStateAction>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await listenToCalendarEventsInteractor.execute(getUserIdInteractor.execute(), _streamController.sink);
      await filterEventsByDateInteractor.execute(getUserIdInteractor.execute(), _streamController.sink, dateTimeHelper.provideCurrentDate());
      final calendarEvents = await getTotalEventsInteractor.execute(getUserIdInteractor.execute());
      state.events = calendarEvents;
      emit(state.copyWith(isLoading: false));
    });

    on<SelectDayEventsActions>((event, emit) {
      filterEventsByDateInteractor.execute(
        getUserIdInteractor.execute(),
        _streamController.sink,
        event.selectedDay,
      );
      emit(state.copyWith(isLoading: false));
    });

    on<RefreshEventsAction>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      emit(state.copyWith(isLoading: false));
    });

    on<EditCalendarFoodEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true));

      final foodEvent = FoodEvent(
        eventId: event.eventId,
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        foodInfo: event.foodInfo,
      );
      editFoodEventInteractor.execute(foodEvent, event.onFinish);

      emit(state.copyWith(isLoading: false));
    });


    on<EditCalendarSportEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final sportEvent = SportEvent(
        eventId: event.eventId,
        userId: getUserIdInteractor.execute(),
        eventDate: event.eventDate,
        sportInfo: event.sportInfo,
        duration: event.duration,
      );
      editSportEventInteractor.execute(sportEvent, event.onFinish);
      emit(state.copyWith(isLoading: false));
    });


    on<EditCalendarSleepEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true));
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
      emit(state.copyWith(isLoading: false));
    });


    on<EditCalendarPoopEventAction>((event, emit) {
      emit(state.copyWith(isLoading: true));
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
      emit(state.copyWith(isLoading: false));
    });


    on<DeleteCalendarEventAction>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      switch (event.calendarEvent.runtimeType) {
        case FoodEvent: await deleteFoodEventInteractor.execute(event.calendarEvent as FoodEvent);
        case SportEvent: await deleteSportEventInteractor.execute(event.calendarEvent as SportEvent);
        case SleepEvent: await deleteSleepEventInteractor.execute(event.calendarEvent as SleepEvent);
        case PoopEvent: await deletePoopEventInteractor.execute(event.calendarEvent as PoopEvent);
        //TODO case SupplementEvent: await deletePoopEventInteractor.execute(event.calendarEvent as PoopEvent);
        //TODO case AnsweredQuestionnaire: await deletePoopEventInteractor.execute(event.calendarEvent as PoopEvent);
      }
      event.onFinish.call();
      emit(state.copyWith(isLoading: false));
    });

  }

  DateTime provideFirstDay() => DateTimeHelper().provideFirstDayForCalendar();
  DateTime provideFocusedDay() => DateTimeHelper().provideFocusedDayForCalendar();
  DateTime provideLastDay() => DateTimeHelper().provideLastDayForCalendar();

  List<CalendarEvent> getEventsForDay(DateTime dateTime) {
    final calendarEvents = state.events;
    return calendarEvents?.where((event) {
      return dateTimeHelper.isSameDay(dateTime, dateTimeHelper.setDateFromMilliseconds(_getEventDateFromCalendarEvent(event)));
    }).toList() ?? [];
  }

  int _getEventDateFromCalendarEvent(CalendarEvent calendarEvent) {
    switch (calendarEvent.runtimeType) {
      case FoodEvent: {
        calendarEvent as FoodEvent;
        return calendarEvent.eventDate;
      }
      case SportEvent: {
        calendarEvent as SportEvent;
        return calendarEvent.eventDate;
      }
      case SleepEvent: {
        calendarEvent as SleepEvent;
        return calendarEvent.eventDate;
      }
      case PoopEvent: {
        calendarEvent as PoopEvent;
        return calendarEvent.eventDate;
      }
      case SupplementEvent: {
        calendarEvent as SupplementEvent;
        return calendarEvent.intakeTime;
      }
      case AnsweredQuestionnaire: {
        calendarEvent as AnsweredQuestionnaire;
        return calendarEvent.eventDate;
      }
      default: 0;
    }
    return 0;
  }

  bool areThereEventsOfType(List<CalendarEvent> events, Type runtimeType) {
    for (var event in events) {
      if (event.runtimeType == runtimeType) {
        return true;
      }
    }
    return false;
  }

}