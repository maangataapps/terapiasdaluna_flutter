// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answered_questionnaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnsweredQuestionnaire _$AnsweredQuestionnaireFromJson(
        Map<String, dynamic> json) =>
    AnsweredQuestionnaire(
      userId: json['userId'] as String,
      eventDate: json['eventDate'] as int,
      eventId: json['eventId'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnsweredQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnsweredQuestionnaireToJson(
        AnsweredQuestionnaire instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'eventDate': instance.eventDate,
      'eventId': instance.eventId,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };

AnsweredQuestion _$AnsweredQuestionFromJson(Map<String, dynamic> json) =>
    AnsweredQuestion(
      questionId: json['questionId'] as int,
      quality: json['quality'] as int?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$AnsweredQuestionToJson(AnsweredQuestion instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'quality': instance.quality,
      'text': instance.text,
    };
