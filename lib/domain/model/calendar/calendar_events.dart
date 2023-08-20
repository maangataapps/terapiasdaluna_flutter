
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

class CalendarEvents {
 List<CalendarEvent> _events = [];
 List<FoodEvent> foodEvents = [];
 List<SportEvent> sportEvents = [];
 List<SleepEvent> sleepEvents = [];
 List<PoopEvent> poopEvents = [];
 List<SupplementEvent> supplementEvents = [];
 List<AnsweredQuestionnaire> questionnaires = [];

  CalendarEvents();
  List<CalendarEvent> get events {
   _events = <CalendarEvent>[
    ...foodEvents,
    ...sportEvents,
    ...sleepEvents,
    ...poopEvents,
    ...supplementEvents,
    ...questionnaires,
   ];
   return _events;
  }

  set events(List<CalendarEvent> calendarEvents) {
   _events = calendarEvents;
  }
}

abstract class CalendarEvent {}