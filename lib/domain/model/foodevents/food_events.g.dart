// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodEvent _$FoodEventFromJson(Map<String, dynamic> json) => FoodEvent(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      foodInfo: json['foodInfo'] as String,
      eventDate: json['eventDate'] as int,
    );

Map<String, dynamic> _$FoodEventToJson(FoodEvent instance) => <String, dynamic>{
      'eventId': instance.eventId,
      'userId': instance.userId,
      'eventDate': instance.eventDate,
      'foodInfo': instance.foodInfo,
    };
