import 'package:terapiasdaluna/domain/model/questions/question.dart';

class QuestionsHelper {
  static String getQuestionTitle(Question question) => '${question.id+1}.- ${question.title}';

  static String getQuestionFromAnsweredQuestion(int questionId) => getQuestionTitle(getQuestionsList().firstWhere((question) => question.id == questionId));

  static List<Question> getQuestionsList() => [
    Question1(),
    Question2(),
    Question3(),
    Question4(),
    Question5(),
    Question6(),
    Question7(),
    Question8(),
    Question9(),
    Question10(),
    Question11(),
  ];


}