import 'package:terapiasdaluna/domain/interactor/questions/save_questionnaire_interactor.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/repository/questions/questions_repository.dart';

class SaveQuestionnaireInteractorImpl extends SaveQuestionnaireInteractor {
  final QuestionsRepository questionsRepository;

  SaveQuestionnaireInteractorImpl({required this.questionsRepository});

  @override
  Future<void> execute(AnsweredQuestionnaire answeredQuestionnaire, Function onFinish) async => await questionsRepository.saveAnsweredQuestionnaire(answeredQuestionnaire, onFinish);

}