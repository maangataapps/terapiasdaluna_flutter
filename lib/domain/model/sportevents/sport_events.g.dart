// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportEvent _$SportEventFromJson(Map<String, dynamic> json) => SportEvent(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      sportInfo: json['sportInfo'] as String,
      eventDate: json['eventDate'] as int,
      duration: json['duration'] as int,
    );

Map<String, dynamic> _$SportEventToJson(SportEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'userId': instance.userId,
      'sportInfo': instance.sportInfo,
      'eventDate': instance.eventDate,
      'duration': instance.duration,
    };
