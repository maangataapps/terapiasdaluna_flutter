import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';

class PoopEventsActions {
  PoopEventsActions();
}

class InitializeStateAction extends PoopEventsActions {
  InitializeStateAction();
}

class SavePoopEventAction extends PoopEventsActions {
  final int poopType;
  final bool abdominalPain;
  final bool flatulence;
  final int eventDate;
  final Function onFinish;

  SavePoopEventAction({
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
    required this.eventDate,
    required this.onFinish,
  });
}

class EditPoopEventAction extends PoopEventsActions {
  final String eventId;
  final int poopType;
  final bool abdominalPain;
  final bool flatulence;
  final int eventDate;
  final Function onFinish;

  EditPoopEventAction({
    required this.eventId,
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
    required this.eventDate,
    required this.onFinish,
  });
}

class DeletePoopEventAction extends PoopEventsActions {
  final PoopEvent poopEvent;

  DeletePoopEventAction({required this.poopEvent});
}