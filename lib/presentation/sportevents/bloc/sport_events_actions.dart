import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';

class SportEventsActions {
  SportEventsActions();
}

class InitializeStateAction extends SportEventsActions {
  InitializeStateAction();
}

class SaveSportEventAction extends SportEventsActions {
  final String sportInfo;
  final int eventDate;
  final int duration;
  final Function onFinish;

  SaveSportEventAction({
    required this.sportInfo,
    required this.eventDate,
    required this.duration,
    required this.onFinish,
  });
}

class DeleteSportEventAction extends SportEventsActions {
  final SportEvent sportEvent;

  DeleteSportEventAction({required this.sportEvent});
}

class EditSportEventAction extends SportEventsActions {
  final String eventId;
  final String sportInfo;
  final int eventDate;
  final int duration;
  final Function onFinish;

  EditSportEventAction({
    required this.eventId,
    required this.sportInfo,
    required this.eventDate,
    required this.duration,
    required this.onFinish,
  });
}