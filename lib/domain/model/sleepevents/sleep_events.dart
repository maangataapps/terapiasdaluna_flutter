import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'sleep_events.g.dart';

@JsonSerializable(explicitToJson: true)
class SleepEvent extends CalendarEvent {
  String eventId;
  String userId;
  int eventDate;
  int quality;
  int sleepTime;

  SleepEvent({
    required this.eventId,
    required this.userId,
    required this.eventDate,
    required this.quality,
    required this.sleepTime,
  });

  factory SleepEvent.fromJson(Map<String, dynamic> json) => _$SleepEventFromJson(json);
  Map<String, dynamic> toJson() => _$SleepEventToJson(this);
}

