import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

class CalendarActions {
  CalendarActions();
}

class InitializeStateAction extends CalendarActions {
  InitializeStateAction();
}

class SelectDayEventsActions extends CalendarActions {
  final DateTime selectedDay;

  SelectDayEventsActions({required this.selectedDay});
}

class RefreshEventsAction extends CalendarActions {
  final DateTime selectedDay;

  RefreshEventsAction({required this.selectedDay});
}

class EditCalendarFoodEventAction extends CalendarActions {
  final String eventId;
  final String foodInfo;
  final int eventDate;
  final Function onFinish;

  EditCalendarFoodEventAction({
    required this.eventId,
    required this.foodInfo,
    required this.eventDate,
    required this.onFinish,
  });
}

class EditCalendarSportEventAction extends CalendarActions {
  final String eventId;
  final String sportInfo;
  final int eventDate;
  final int duration;
  final Function onFinish;

  EditCalendarSportEventAction({
    required this.eventId,
    required this.sportInfo,
    required this.eventDate,
    required this.duration,
    required this.onFinish,
  });
}

class EditCalendarSleepEventAction extends CalendarActions {
  String eventId;
  int quality;
  int eventDate;
  int sleepTime;
  Function onFinish;

  EditCalendarSleepEventAction({
    required this.eventId,
    required this.quality,
    required this.eventDate,
    required this.sleepTime,
    required this.onFinish,
  });
}

class EditCalendarPoopEventAction extends CalendarActions {
  final String eventId;
  final int poopType;
  final bool abdominalPain;
  final bool flatulence;
  final int eventDate;
  final Function onFinish;

  EditCalendarPoopEventAction({
    required this.eventId,
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
    required this.eventDate,
    required this.onFinish,
  });
}

class DeleteCalendarEventAction extends CalendarActions {
  final CalendarEvent calendarEvent;
  final Function onFinish;

  DeleteCalendarEventAction({required this.calendarEvent, required this.onFinish});
}

