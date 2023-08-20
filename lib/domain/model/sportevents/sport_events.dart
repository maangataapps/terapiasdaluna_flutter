import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'sport_events.g.dart';

@JsonSerializable(explicitToJson: true)
class SportEvent extends CalendarEvent {
  String eventId;
  String userId;
  String sportInfo;
  int eventDate;
  int duration;

  SportEvent({
    required this.eventId,
    required this.userId,
    required this.sportInfo,
    required this.eventDate,
    required this.duration,
  });

  factory SportEvent.fromJson(Map<String, dynamic> json) => _$SportEventFromJson(json);
  Map<String, dynamic> toJson() => _$SportEventToJson(this);
}