import 'package:json_annotation/json_annotation.dart';
import 'package:terapiasdaluna/domain/model/calendar/calendar_events.dart';

part 'answered_questionnaire.g.dart';

@JsonSerializable(explicitToJson: true)
class AnsweredQuestionnaire extends CalendarEvent {
  final String userId;
  final int eventDate;
  final String eventId;
  final List<AnsweredQuestion> answers;

  AnsweredQuestionnaire({
    required this.userId,
    required this.eventDate,
    required this.eventId,
    required this.answers,
  });

  factory AnsweredQuestionnaire.fromJson(Map<String, dynamic> json) => _$AnsweredQuestionnaireFromJson(json);
  Map<String, dynamic> toJson() => _$AnsweredQuestionnaireToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnsweredQuestion {
  final int questionId;
  final int? quality;
  final String? text;

  AnsweredQuestion({
    required this.questionId,
    required this.quality,
    required this.text,
  });

  factory AnsweredQuestion.fromJson(Map<String, dynamic> json) => _$AnsweredQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$AnsweredQuestionToJson(this);
}