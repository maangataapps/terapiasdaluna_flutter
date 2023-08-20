import 'package:terapiasdaluna/domain/model/questions/question.dart';

class QuestionUI {
  Question question;
  bool hasBeenAnswered;

  QuestionUI({
    required this.question,
    required this.hasBeenAnswered,
  });
}