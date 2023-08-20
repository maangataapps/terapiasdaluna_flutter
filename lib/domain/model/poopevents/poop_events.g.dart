// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poop_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoopEvent _$PoopEventFromJson(Map<String, dynamic> json) => PoopEvent(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      eventDate: json['eventDate'] as int,
      poopType: json['poopType'] as int,
      abdominalPain: json['abdominalPain'] as bool,
      flatulence: json['flatulence'] as bool,
    );

Map<String, dynamic> _$PoopEventToJson(PoopEvent instance) => <String, dynamic>{
      'eventId': instance.eventId,
      'userId': instance.userId,
      'eventDate': instance.eventDate,
      'poopType': instance.poopType,
      'abdominalPain': instance.abdominalPain,
      'flatulence': instance.flatulence,
    };
