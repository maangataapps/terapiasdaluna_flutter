import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/domain/repository/calendar/calendar_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class CalendarRepositoryImpl extends CalendarRepository {
  final FirebaseDatabase firebaseDatabase;
  final List<FoodEvent> _foodEvents = [];
  final List<SportEvent> _sportEvents = [];
  final List<PoopEvent> _poopEvents = [];
  final List<SleepEvent> _sleepEvents = [];
  final List<SupplementEvent> _supplementEvents = [];
  final List<AnsweredQuestionnaire> _questionnaires = [];
  final EventsHelper _eventsHelper = EventsHelper();
  final CalendarEvents _calendarEvents = CalendarEvents();

  CalendarRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<void> listenToCalendarEvents(String userId, StreamSink<List<CalendarEvent>> streamSink) async {
    var foodEventsRef = firebaseDatabase.ref('${constants.foodEvents}/$userId');
    var sportEventsRef = firebaseDatabase.ref('${constants.sportEvents}/$userId');
    var poopEventsRef = firebaseDatabase.ref('${constants.poopEvents}/$userId');
    var sleepEventsRef = firebaseDatabase.ref('${constants.sleepEvents}/$userId');
    var supplementEventsRef = firebaseDatabase.ref('${constants.supplementEvents}/$userId');
    var questionnairesRef = firebaseDatabase.ref('${constants.questionnaires}/$userId');

    _eventsHelper.listenToFoodEvents(
        foodEventsRef,
        _foodEvents, () {
          _calendarEvents.foodEvents = _foodEvents;
          streamSink.add(_calendarEvents.events);
        },
      false,
    );

    _eventsHelper.listenToSportEvents(
        sportEventsRef,
        _sportEvents,
            () {
          _calendarEvents.sportEvents = _sportEvents;
          streamSink.add(_calendarEvents.events);
        },
      false,
    );

    _eventsHelper.listenToPoopEvents(
      poopEventsRef,
      _poopEvents,
      () {
        _calendarEvents.poopEvents = _poopEvents;
        streamSink.add(_calendarEvents.events);
        },
      false,
    );

    _eventsHelper.listenToSleepEvents(
      sleepEventsRef,
      _sleepEvents,
          () {
        _calendarEvents.sleepEvents = _sleepEvents;
        streamSink.add(_calendarEvents.events);
      },
      false,
    );

    _eventsHelper.listenToSupplementEvents(
      supplementEventsRef,
      _supplementEvents,
          () {
        _calendarEvents.supplementEvents = _supplementEvents;
        streamSink.add(_calendarEvents.events);
      },
      false,
    );

    _eventsHelper.listenToQuestionnaires(
      questionnairesRef,
      _questionnaires,
          () {
        _calendarEvents.questionnaires = _questionnaires;
        streamSink.add(_calendarEvents.events);
      },
      false,
    );

  }

  @override
  Future<void> filterCalendarEventsByDate(
      String userId,
      StreamSink<List<CalendarEvent>> streamSink,
      DateTime dateTime,
      ) async {
    List<CalendarEvent> events = [];
    _addCalendarEventFromGivenDate(events, constants.foodEvents, userId, dateTime, (element) => _eventsHelper.createFoodEventFromDataSnapshot(element), (events) => streamSink.add(events));
    _addCalendarEventFromGivenDate(events, constants.sportEvents, userId, dateTime, (element) => _eventsHelper.createSportEventFromDataSnapshot(element), (events) => streamSink.add(events));
    _addCalendarEventFromGivenDate(events, constants.sleepEvents, userId, dateTime, (element) => _eventsHelper.createSleepEventFromDataSnapshot(element), (events) => streamSink.add(events));
    _addCalendarEventFromGivenDate(events, constants.poopEvents, userId, dateTime, (element) => _eventsHelper.createPoopEventFromDataSnapshot(element), (events) => streamSink.add(events));
    _addCalendarEventFromGivenDate(events, constants.supplementEvents, userId, dateTime, (element) => _eventsHelper.createSupplementEventFromDataSnapshot(element), (events) => streamSink.add(events));
    _addCalendarEventFromGivenDate(events, constants.questionnaires, userId, dateTime, (element) => _eventsHelper.createQuestionnaireFromDataSnapshot(element), (events) => streamSink.add(events));
  }

  @override
  Future<List<CalendarEvent>> getTotalEvents(String userId) async {
    List<CalendarEvent> events = [];
    await _getEventsOfGivenType(userId, constants.foodEvents, (element) => _eventsHelper.createFoodEventFromDataSnapshot(element)).then((value) => events.addAll(value));
    await _getEventsOfGivenType(userId, constants.sportEvents, (element) => _eventsHelper.createSportEventFromDataSnapshot(element)).then((value) => events.addAll(value));
    await _getEventsOfGivenType(userId, constants.sleepEvents, (element) => _eventsHelper.createSleepEventFromDataSnapshot(element)).then((value) => events.addAll(value));
    await _getEventsOfGivenType(userId, constants.poopEvents, (element) => _eventsHelper.createPoopEventFromDataSnapshot(element)).then((value) => events.addAll(value));
    await _getEventsOfGivenType(userId, constants.supplementEvents, (element) => _eventsHelper.createSupplementEventFromDataSnapshot(element)).then((value) => events.addAll(value));
    await _getEventsOfGivenType(userId, constants.questionnaires, (element) => _eventsHelper.createQuestionnaireFromDataSnapshot(element)).then((value) => events.addAll(value));
    return events;
  }


  void _addCalendarEventFromGivenDate(
      List<CalendarEvent> events,
      String eventType,
      String userId,
      DateTime dateTime,
      Function createEvent,
      Function onSink,
      ) async {
    final dateTimeHelper = DateTimeHelper();
    var ref = firebaseDatabase.ref('$eventType/$userId');
    var query = await ref.get();
    for (var element in query.children) {
      int eventDate;
      if (eventType == constants.supplementEvents) {
        eventDate = element.child(constants.intakeTime).value as int;
      } else {
        eventDate = element.child(constants.eventDate).value as int;
      }
      final dateFormatted = dateTimeHelper.setDateFromMilliseconds(eventDate);
      if (dateTimeHelper.isSameDay(dateTime, dateFormatted)) {
        final event = createEvent.call(element);
        events.add(event);
      }
    }
    onSink.call(events);
  }

  Future<List<CalendarEvent>> _getEventsOfGivenType(String userId, String eventType, Function createEvent) async {
    final events = <CalendarEvent>[];
    var ref = firebaseDatabase.ref('$eventType/$userId');
    var query = await ref.get();
    for (var element in query.children) {
      final event = createEvent.call(element);
      events.add(event);
    }
    return events;
  }

}