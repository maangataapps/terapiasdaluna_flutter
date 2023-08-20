import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'poop_events.g.dart';

@JsonSerializable(explicitToJson: true)
class PoopEvent extends CalendarEvent {
  String eventId;
  String userId;
  int eventDate;
  int poopType;
  bool abdominalPain;
  bool flatulence;

  PoopEvent({
    required this.eventId,
    required this.userId,
    required this.eventDate,
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
  });

  factory PoopEvent.fromJson(Map<String, dynamic> json) => _$PoopEventFromJson(json);
  Map<String, dynamic> toJson() => _$PoopEventToJson(this);
}