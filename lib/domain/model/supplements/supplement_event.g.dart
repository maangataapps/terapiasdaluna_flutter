// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplement_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementEvent _$SupplementEventFromJson(Map<String, dynamic> json) =>
    SupplementEvent(
      eventId: json['eventId'] as String,
      supplementId: json['supplementId'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      intakeTime: json['intakeTime'] as int,
      timeOfSupplement: json['timeOfSupplement'] as int?,
      outOfMeals: json['outOfMeals'] as bool,
    );

Map<String, dynamic> _$SupplementEventToJson(SupplementEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'supplementId': instance.supplementId,
      'userId': instance.userId,
      'name': instance.name,
      'intakeTime': instance.intakeTime,
      'timeOfSupplement': instance.timeOfSupplement,
      'outOfMeals': instance.outOfMeals,
    };
