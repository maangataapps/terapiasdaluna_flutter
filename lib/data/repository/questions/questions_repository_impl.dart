import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/repository/questions/questions_repository.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class QuestionsRepositoryImpl extends QuestionsRepository {
  final FirebaseDatabase firebaseDatabase;

  QuestionsRepositoryImpl({required this.firebaseDatabase});

  @override
  Future<void> saveAnsweredQuestionnaire(AnsweredQuestionnaire answeredQuestionnaire, Function onFinish) async {
    await saveEvent(firebaseDatabase, constants.questionnaires, answeredQuestionnaire.userId, answeredQuestionnaire.toJson(), onFinish);
  }

}