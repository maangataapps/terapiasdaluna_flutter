import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';

class SleepEventsActions {
  SleepEventsActions();
}

class InitializeStateAction extends SleepEventsActions {
  InitializeStateAction();
}

class SaveSleepEventAction extends SleepEventsActions {
  int quality;
  int eventDate;
  int sleepTime;
  Function onFinish;

  SaveSleepEventAction({required this.quality, required this.eventDate, required this.sleepTime, required this.onFinish});
}

class EditSleepEventAction extends SleepEventsActions {
  String eventId;
  int quality;
  int eventDate;
  int sleepTime;
  Function onFinish;

  EditSleepEventAction({required this.eventId, required this.quality, required this.eventDate, required this.sleepTime, required this.onFinish});
}

class DeleteSleepEventAction extends SleepEventsActions {
  final SleepEvent sleepEvent;

  DeleteSleepEventAction({required this.sleepEvent});
}