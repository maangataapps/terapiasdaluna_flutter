import 'package:terapiasdaluna/domain/model/questions/answer.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';
import 'package:terapiasdaluna/presentation/questions/model/question_ui.dart';

class QuestionsState {
  bool isLoading;
  ErrorTypes? onError;
  List<QuestionUI>? questionsList;
  List<Answer>? answerList;

  QuestionsState({
    required this.isLoading,
    required this.onError,
    this.questionsList,
    this.answerList,
  });

  QuestionsState copyWith({
    required bool isLoading,
    required ErrorTypes? onError,
    List<QuestionUI>? questionsList,
    List<Answer>? answerList,
  }) {
    return QuestionsState(
      isLoading: isLoading,
      onError: onError,
      questionsList: questionsList ?? this.questionsList,
      answerList: answerList ?? this.answerList,
    );
  }
}