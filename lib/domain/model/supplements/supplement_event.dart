import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'supplement_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SupplementEvent extends CalendarEvent {
  final String eventId;
  final String supplementId;
  String userId;
  final String name;
  final int intakeTime;
  final int? timeOfSupplement;
  bool outOfMeals;


  SupplementEvent({
    required this.eventId,
    required this.supplementId,
    required this.userId,
    required this.name,
    required this.intakeTime,
    this.timeOfSupplement,
    required this.outOfMeals,
  });

  factory SupplementEvent.fromJson(Map<String, dynamic> json) => _$SupplementEventFromJson(json);
  Map<String, dynamic> toJson() => _$SupplementEventToJson(this);
}

enum TimeOfSupplement {
  morning, lunch, dinner, night
}