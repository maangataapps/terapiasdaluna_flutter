import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'food_events.g.dart';

@JsonSerializable(explicitToJson: true)
class FoodEvent extends CalendarEvent {
  String eventId;
  String userId;
  int eventDate;
  String foodInfo;

  FoodEvent({
    required this.eventId,
    required this.userId,
    required this.foodInfo,
    required this.eventDate,
  });

  factory FoodEvent.fromJson(Map<String, dynamic> json) => _$FoodEventFromJson(json);
  Map<String, dynamic> toJson() => _$FoodEventToJson(this);
}