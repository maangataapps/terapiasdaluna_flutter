// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SleepEvent _$SleepEventFromJson(Map<String, dynamic> json) => SleepEvent(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      eventDate: json['eventDate'] as int,
      quality: json['quality'] as int,
      sleepTime: json['sleepTime'] as int,
    );

Map<String, dynamic> _$SleepEventToJson(SleepEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'userId': instance.userId,
      'eventDate': instance.eventDate,
      'quality': instance.quality,
      'sleepTime': instance.sleepTime,
    };
