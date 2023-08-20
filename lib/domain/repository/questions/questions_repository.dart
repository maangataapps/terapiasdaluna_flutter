import 'package:terapiasdaluna/data/repository/events_repository_impl.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';

abstract class QuestionsRepository extends EventsRepositoryImpl {
  Future<void> saveAnsweredQuestionnaire(AnsweredQuestionnaire answeredQuestionnaire, Function onFinish);
}