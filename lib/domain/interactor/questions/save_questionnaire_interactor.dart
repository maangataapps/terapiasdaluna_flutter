import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';

abstract class SaveQuestionnaireInteractor {
  Future<void> execute(AnsweredQuestionnaire answeredQuestionnaire, Function onFinish);
}