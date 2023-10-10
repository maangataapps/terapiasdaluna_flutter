import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsHelper {
  final DateTimeHelper _dateTimeHelper = DateTimeHelper();

  void listenToFoodEvents(
      DatabaseReference foodEventsRef,
      List<FoodEvent> foodEvents,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      foodEventsRef.onChildAdded.listen((event) {
        final foodEvent = _createFoodEventFromDatabaseEvent(event);
        if (!foodEvents.map((foodEvent) => foodEvent.eventId).contains(foodEvent.eventId)) {
          foodEvents.add(foodEvent);
        }
        onListen.call();
      });
    }

    foodEventsRef.onChildRemoved.listen((event) {
      foodEvents.removeWhere((foodEvent) => foodEvent.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();
    });

    foodEventsRef.onChildChanged.listen((event) {
      if (foodEvents.isNotEmpty) {
        final editedFoodEvent = _createFoodEventFromDatabaseEvent(event);
        final eventIndex = foodEvents.indexWhere((foodEvent) => foodEvent.eventId == editedFoodEvent.eventId);
        if (eventIndex != -1) {
          foodEvents.replaceRange(eventIndex, eventIndex + 1, [editedFoodEvent]);
          onListen.call();
        }
      }
    });
  }

  void listenToSportEvents(
      DatabaseReference sportEventsRef,
      List<SportEvent> sportEvents,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      sportEventsRef.onChildAdded.listen((event) {
        final sportEvent = _createSportEventFromDatabaseEvent(event);
        if (!sportEvents.map((sportEvent) => sportEvent.eventId).contains(sportEvent.eventId)) {
          sportEvents.add(sportEvent);
        }
        sportEvents.reversed.toList();
        onListen.call();
      });
    }

    sportEventsRef.onChildRemoved.listen((event) {
      sportEvents.removeWhere((sportEvent) => sportEvent.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();

    });

    sportEventsRef.onChildChanged.listen((event) {
      if (sportEvents.isNotEmpty) {
        final editedSportEvent = _createSportEventFromDatabaseEvent(event);
        final eventIndex = sportEvents.indexWhere((sportEvent) => sportEvent.eventId == editedSportEvent.eventId);
        if (eventIndex != -1) {
          sportEvents.replaceRange(eventIndex, eventIndex + 1, [editedSportEvent]);
          onListen.call();
        }
      }
    });
  }

  void listenToPoopEvents(
      DatabaseReference poopEventsRef,
      List<PoopEvent> poopEvents,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      poopEventsRef.onChildAdded.listen((event) {
        final poopEvent = _createPoopEventFromDatabaseEvent(event);
        if (!poopEvents.map((poopEvent) => poopEvent.eventId).contains(poopEvent.eventId)) {
          poopEvents.add(poopEvent);
        }
        poopEvents.reversed.toList();
        onListen.call();
      });
    }

    poopEventsRef.onChildRemoved.listen((event) {
      poopEvents.removeWhere((poopEvent) => poopEvent.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();
    });

    poopEventsRef.onChildChanged.listen((event) {
      if (poopEvents.isNotEmpty) {
        final editedPoopEvent = _createPoopEventFromDatabaseEvent(event);
        final eventIndex = poopEvents.indexWhere((poopEvent) => poopEvent.eventId == editedPoopEvent.eventId);
        if (eventIndex != -1) {
          poopEvents.replaceRange(eventIndex, eventIndex + 1, [editedPoopEvent]);
          onListen.call();
        }
      }
    });
  }

  void listenToSleepEvents(
      DatabaseReference sleepEventsRef,
      List<SleepEvent> sleepEvents,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      sleepEventsRef.onChildAdded.listen((event) {
        final sleepEvent = _createSleepEventFromDatabaseEvent(event);
        if (!sleepEvents.map((sleepEvent) => sleepEvent.eventId).contains(sleepEvent.eventId)) {
          sleepEvents.add(sleepEvent);
        }
        sleepEvents.reversed.toList();
        onListen.call();
      });
    }

    sleepEventsRef.onChildRemoved.listen((event) {
      sleepEvents.removeWhere((sleepEvent) => sleepEvent.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();
    });

    sleepEventsRef.onChildChanged.listen((event) {
      if (sleepEvents.isNotEmpty) {
        final editedSleepEvent = _createSleepEventFromDatabaseEvent(event);
        final eventIndex = sleepEvents.indexWhere((sleepEvent) => sleepEvent.eventId == editedSleepEvent.eventId);
        if (eventIndex != -1) {
          sleepEvents.replaceRange(eventIndex, eventIndex + 1, [editedSleepEvent]);
          onListen.call();
        }
      }
    });
  }

  void listenToSupplements(
      DatabaseReference supplementsRef,
      List<Supplement> supplements,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      supplementsRef.onChildAdded.listen((event) {
        final supplement = createSupplementFromDatabaseEvent(event.snapshot);
        if (!supplements.map((supplement) => supplement.id).contains(supplement.id)) {
          supplements.add(supplement);
        }
        onListen.call();
      });
    }

    supplementsRef.onChildChanged.listen((event) {
      final editedSupplement = createSupplementFromDatabaseEvent(event.snapshot);
      final eventIndex = supplements.indexWhere((supplement) => supplement.id == editedSupplement.id);
      if (eventIndex != -1) {
        supplements.replaceRange(eventIndex, eventIndex + 1, [editedSupplement]);
        onListen.call();
      }
    });
  }

  void listenToSupplementEvents(
      DatabaseReference supplementEventsRef,
      List<SupplementEvent> supplementEvents,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      supplementEventsRef.onChildAdded.listen((event) {
        final supplement = _createSupplementEventFromDatabaseEvent(event);
        if (!supplementEvents.map((supplement) => supplement.eventId).contains(supplement.eventId)) {
          supplementEvents.add(supplement);
        }
        supplementEvents.reversed.toList();
        onListen.call();
      });
    }

    supplementEventsRef.onChildRemoved.listen((event) {
      supplementEvents.removeWhere((supplement) => supplement.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();
    });

    supplementEventsRef.onChildChanged.listen((event) {
      if (supplementEvents.isNotEmpty) {
        final editedSupplementEvent = _createSupplementEventFromDatabaseEvent(event);
        final eventIndex = supplementEvents.indexWhere((supplement) => supplement.eventId == editedSupplementEvent.eventId);
        if (eventIndex != -1) {
          supplementEvents.replaceRange(eventIndex, eventIndex + 1, [editedSupplementEvent]);
          onListen.call();
        }
      }
    });
  }

  void listenToQuestionnaires(
      DatabaseReference questionnairesRef,
      List<AnsweredQuestionnaire> questionnaires,
      Function onListen,
      bool listenForAddedChildren,
      ) {
    if (listenForAddedChildren) {
      questionnairesRef.onChildAdded.listen((event) {
        final questionnaire = _createQuestionnaireFromDatabaseEvent(event);
        if (!questionnaires.map((questionnaire) => questionnaire.eventId).contains(questionnaire.eventId)) {
          questionnaires.add(questionnaire);
        }
        questionnaires.reversed.toList();
        onListen.call();
      });
    }

    questionnairesRef.onChildRemoved.listen((event) {
      questionnaires.removeWhere((questionnaire) => questionnaire.eventId == event.snapshot.child(constants.eventId).value);
      onListen.call();
    });

    questionnairesRef.onChildChanged.listen((event) {
      if (questionnaires.isNotEmpty) {
        final editedQuestionnaire = _createQuestionnaireFromDatabaseEvent(event);
        final eventIndex = questionnaires.indexWhere((questionnaire) => questionnaire.eventId == editedQuestionnaire.eventId);
        if (eventIndex != -1) {
          questionnaires.replaceRange(eventIndex, eventIndex + 1, [editedQuestionnaire]);
          onListen.call();
        }
      }
    });
  }

  FoodEvent createFoodEventFromDataSnapshot(DataSnapshot element) {
    return FoodEvent(
      eventId: element.child(constants.eventId).value as String,
      userId: element.child(constants.userId).value as String,
      foodInfo: element.child(constants.foodInfo).value as String,
      eventDate: element.child(constants.eventDate).value as int,
    );
  }

  SportEvent createSportEventFromDataSnapshot(DataSnapshot element) {
    return SportEvent(
      eventId: element.child(constants.eventId).value as String,
      userId: element.child(constants.userId).value as String,
      sportInfo: element.child(constants.sportInfo).value as String,
      eventDate: element.child(constants.eventDate).value as int,
      duration: element.child(constants.duration).value as int,
    );
  }

  PoopEvent createPoopEventFromDataSnapshot(DataSnapshot element) {
    return PoopEvent(
      eventId: element.child(constants.eventId).value as String,
      userId: element.child(constants.userId).value as String,
      poopType: element.child(constants.poopType).value as int,
      abdominalPain: element.child(constants.abdominalPain).value as bool,
      flatulence: element.child(constants.flatulence).value as bool,
      eventDate: element.child(constants.eventDate).value as int,
    );
  }

  SleepEvent createSleepEventFromDataSnapshot(DataSnapshot element) {
    return SleepEvent(
      eventId: element.child(constants.eventId).value as String,
      userId: element.child(constants.userId).value as String,
      eventDate: element.child(constants.eventDate).value as int,
      quality: element.child(constants.quality).value as int,
      sleepTime: element.child(constants.sleepTime).value as int,
    );
  }

  SupplementEvent createSupplementEventFromDataSnapshot(DataSnapshot element) {
    return SupplementEvent(
      userId: element.child(constants.userId).value as String,
      supplementId: element.child(constants.supplementId).value as String,
      eventId: element.child(constants.eventId).value as String,
      name: element.child(constants.name).value as String,
      intakeTime: element.child(constants.intakeTime).value as int,
      timeOfSupplement: element.child(constants.timeOfSupplement).value as int?,
      outOfMeals: element.child(constants.outOfMeals).value as bool,
    );
  }

  AnsweredQuestionnaire createQuestionnaireFromDataSnapshot(DataSnapshot element) {
    return AnsweredQuestionnaire(
      userId: element.child(constants.userId).value as String,
      eventId: element.child(constants.eventId).value as String,
      eventDate: element.child(constants.eventDate).value as int,
      answers: (element.child(constants.answers).value as List).map((value) => AnsweredQuestion(questionId: value[constants.questionId], quality: value[constants.quality], text: value[constants.text])).toList(),
    );
  }

  Supplement createSupplementFromDatabaseEvent(DataSnapshot snapshot) {
    return Supplement(
      userId: snapshot.child(constants.userId).value as String,
      id: snapshot.child(constants.id).value as String,
      name: snapshot.child(constants.name).value as String,
      dose: Dose.fromJson(convertToStringDynamicMap(snapshot.child(constants.dose).value)),
      intakeForm: snapshot.child(constants.intakeForm).value as int,
      quantityPerBox: snapshot.child(constants.quantityPerBox).value as int,
      quantityPerTake: snapshot.child(constants.quantityPerTake).value as int,
      intakesTimes: IntakesTimes.fromJson(convertToIntakeTimeMap(snapshot.child(constants.intakesTimes).value)),
      isActivated: snapshot.child(constants.isActivated).value as bool,
      outOfMeals: snapshot.child(constants.outOfMeals).value as bool,
    );
  }

  List<Reminder> getRemindersFromSupplement(Supplement supplement, List<int> eventDates) {
    final supplementEvents = <Reminder>[];
    if (supplement.intakesTimes.morning.isTakingIt) supplementEvents.add(_createReminder(supplement, supplement.intakesTimes.morning.exactTime!, TimeOfSupplement.morning, eventDates));
    if (supplement.intakesTimes.lunch.isTakingIt) supplementEvents.add(_createReminder(supplement, supplement.intakesTimes.lunch.exactTime!, TimeOfSupplement.lunch, eventDates));
    if (supplement.intakesTimes.dinner.isTakingIt) supplementEvents.add(_createReminder(supplement, supplement.intakesTimes.dinner.exactTime!, TimeOfSupplement.dinner, eventDates));
    if (supplement.intakesTimes.night.isTakingIt) supplementEvents.add(_createReminder(supplement, supplement.intakesTimes.night.exactTime!, TimeOfSupplement.night, eventDates));

    return supplementEvents;
  }

  List<CalendarEvent> getEventsFromGivenDate(CalendarEvents calendarEvents, DateTime date) {
    final calendarEvent = CalendarEvents();
    for (var event in calendarEvent.events) {
      switch (event.runtimeType) {
        case FoodEvent: {
          event as FoodEvent;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.eventDate)) {
            calendarEvent.foodEvents.add(event);
          }
        }
        case SportEvent: {
          event as SportEvent;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.eventDate)) {
            calendarEvent.sportEvents.add(event);
          }
        }
        case SleepEvent: {
          event as SleepEvent;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.eventDate)) {
            calendarEvent.sleepEvents.add(event);
          }
        }
        case PoopEvent: {
          event as PoopEvent;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.eventDate)) {
            calendarEvent.poopEvents.add(event);
          }
        }
        case SupplementEvent: {
          event as SupplementEvent;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.intakeTime)) {
            calendarEvent.supplementEvents.add(event);
          }
        }
        case AnsweredQuestionnaire: {
          event as AnsweredQuestionnaire;
          if (_dateTimeHelper.isSameGivenDateFromMillisecondsDate(date, event.eventDate)) {
            calendarEvent.questionnaires.add(event);
          }
        }
      }
    }
    return calendarEvent.events;
  }

  Map<String, dynamic> convertToStringDynamicMap(Object? mapObject) {
    mapObject as Map<Object?, Object?>;
    Map<String, dynamic> myMap = mapObject.map((key, value) => MapEntry(key as String, value as dynamic));
    return myMap;
  }

  Map<String, dynamic> convertToIntakeTimeMap(Object? mapObject) {
    mapObject as Map<Object?, Object?>;
    Map<String, dynamic> myMap = mapObject.map((key, value) {
      final valueMap = convertToStringDynamicMap(value);
      return MapEntry(key as String, valueMap);
    });
    return myMap;
  }

  String getTimeOfIntakeName(BuildContext context, int timeOfSupplement) {
    switch (timeOfSupplement) {
      case 0: return AppLocalizations.of(context)!.morning;
      case 1: return AppLocalizations.of(context)!.lunch;
      case 2: return AppLocalizations.of(context)!.dinner;
      case 3: return AppLocalizations.of(context)!.night;
      default: return '';
    }
  }

  SportEvent _createSportEventFromDatabaseEvent(DatabaseEvent event) {
    return SportEvent(
      eventId: event.snapshot.child(constants.eventId).value as String,
      userId: event.snapshot.child(constants.userId).value as String,
      sportInfo: event.snapshot.child(constants.sportInfo).value as String,
      eventDate: event.snapshot.child(constants.eventDate).value as int,
      duration: event.snapshot.child(constants.duration).value as int,
    );
  }

  PoopEvent _createPoopEventFromDatabaseEvent(DatabaseEvent event) {
    return PoopEvent(
      eventId: event.snapshot.child(constants.eventId).value as String,
      userId: event.snapshot.child(constants.userId).value as String,
      poopType: event.snapshot.child(constants.poopType).value as int,
      abdominalPain: event.snapshot.child(constants.abdominalPain).value as bool,
      flatulence: event.snapshot.child(constants.flatulence).value as bool,
      eventDate: event.snapshot.child(constants.eventDate).value as int,
    );
  }

  SleepEvent _createSleepEventFromDatabaseEvent(DatabaseEvent event) {
    return SleepEvent(
      eventId: event.snapshot.child(constants.eventId).value as String,
      userId: event.snapshot.child(constants.userId).value as String,
      eventDate: event.snapshot.child(constants.eventDate).value as int,
      quality: event.snapshot.child(constants.quality).value as int,
      sleepTime: event.snapshot.child(constants.sleepTime).value as int,
    );
  }

  SupplementEvent _createSupplementEventFromDatabaseEvent(DatabaseEvent event) {
    return SupplementEvent(
      userId: event.snapshot.child(constants.userId).value as String,
      supplementId: event.snapshot.child(constants.supplementId).value as String,
      eventId: event.snapshot.child(constants.eventId).value as String,
      name: event.snapshot.child(constants.name).value as String,
      intakeTime: event.snapshot.child(constants.intakeTime).value as int,
      timeOfSupplement: event.snapshot.child(constants.timeOfSupplement).value as int?,
      outOfMeals: event.snapshot.child(constants.outOfMeals).value as bool,
    );
  }

  AnsweredQuestionnaire _createQuestionnaireFromDatabaseEvent(DatabaseEvent event) {
    return AnsweredQuestionnaire(
      userId: event.snapshot.child(constants.userId).value as String,
      eventId: event.snapshot.child(constants.eventId).value as String,
      eventDate: event.snapshot.child(constants.eventDate).value as int,
      answers: (event.snapshot.child(constants.answers).value as List).map((value) => AnsweredQuestion(questionId: value[constants.questionId], quality: value[constants.quality], text: value[constants.text])).toList(),
    );
  }

  FoodEvent _createFoodEventFromDatabaseEvent(DatabaseEvent event) {
    return FoodEvent(
      eventId: event.snapshot.child(constants.eventId).value as String,
      userId: event.snapshot.child(constants.userId).value as String,
      foodInfo: event.snapshot.child(constants.foodInfo).value as String,
      eventDate: event.snapshot.child(constants.eventDate).value as int,
    );
  }

  Reminder _createReminder(Supplement supplement, String exactTime, TimeOfSupplement timeOfSupplement, List<int> eventDates) {
    final hour = int.parse(exactTime.split(':')[0]);
    final minutes = int.parse(exactTime.split(':')[1]);
    final intakeTime = _dateTimeHelper.getTimeInMillisecondsFromHourMinutes(hour, minutes);

    final supplementEvent = SupplementEvent(
      eventId: getEventId(),
      supplementId: supplement.id,
      userId: supplement.userId!,
      name: supplement.name,
      intakeTime: intakeTime,
      timeOfSupplement: timeOfSupplement.index,
      outOfMeals: supplement.outOfMeals,
    );

    final hasBeenTaken = eventDates
        .map((date) => _dateTimeHelper.setDateFromMilliseconds(date).copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    ),)
        .contains(_dateTimeHelper.setDateFromMilliseconds(intakeTime).copyWith(second: 0, millisecond: 0, microsecond: 0));
    return Reminder(
      hasBeenTaken: hasBeenTaken,
      supplementEvent: supplementEvent,
    );
  }

}