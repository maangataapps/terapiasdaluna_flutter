import 'package:terapiasdaluna/domain/interactor/questions/save_questionnaire_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/questions/save_questionnaire_interactor.dart';
import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/model/questions/answer.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/questions/question.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/questions_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_utils.dart';
import 'package:terapiasdaluna/presentation/base/bloc/base_bloc.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_actions.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_state.dart';
import 'package:terapiasdaluna/presentation/questions/model/question_ui.dart';

class QuestionsBloc extends BaseBloc<QuestionsActions, QuestionsState> {
  final GetUserIdInteractor getUserIdInteractor;
  final SaveQuestionnaireInteractor saveQuestionnaireInteractor;
  final _dateTimeHelper = DateTimeHelper();

  QuestionsBloc({
    required this.getUserIdInteractor,
    required this.saveQuestionnaireInteractor,
  }) : super(QuestionsState(
    isLoading: false,
    onError: null,
    questionsList: [],
    answerList: [],
  ),) {

    on<InitializeStateAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      state.questionsList = QuestionsHelper.getQuestionsList().map((question) => QuestionUI(question: question, hasBeenAnswered: false)).toList();

      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<SelectQualityAction>((event, emit) {
      final modifyingAnswer = state.answerList!.firstWhere((answer) => answer.questionId == event.questionId, orElse: () => Answer(questionId: event.questionId));
      final answerIndex = state.answerList!.indexOf(modifyingAnswer);
      modifyingAnswer.quality = event.quality;
      if (answerIndex == -1) {
        state.answerList!.add(modifyingAnswer);
      } else {
        state.answerList!.replaceRange(answerIndex, answerIndex + 1, [modifyingAnswer]);
      }
      state.questionsList!.firstWhere((questionUI) => questionUI.question.id == event.questionId).hasBeenAnswered = true;
      emit(state.copyWith(isLoading: false, onError: null));
    });

    on<FinishQuestionsAction>((event, emit) async {
      emit(state.copyWith(isLoading: true, onError: null));
      bool allQuestionsAnswered = true;
      for (var questionUI in state.questionsList!) {
        if (questionUI.question.questionType != QuestionType.text && questionUI.hasBeenAnswered == false) {
          allQuestionsAnswered = false;
        }
      }
      if (allQuestionsAnswered) {
        final questionsAnswered = state.answerList!.map((answer) => AnsweredQuestion(questionId: answer.questionId, quality: answer.quality, text: answer.text)).toList();
        final answeredQuestionnaire = AnsweredQuestionnaire(
          userId: getUserIdInteractor.execute(),
          eventDate: _dateTimeHelper.provideCurrentDate().millisecondsSinceEpoch,
          eventId: getEventIdFromDate(),
          answers: questionsAnswered,
        );
        try {
          await saveQuestionnaireInteractor.execute(answeredQuestionnaire, event.onFinish);
          emit(state.copyWith(isLoading: false, onError: null));
        } catch (error) {
          emit(state.copyWith(isLoading: false, onError: ErrorTypes.errorSavingEvent));
        }
      } else {
        emit(state.copyWith(isLoading: false, onError: ErrorTypes.hasToAnswerAllQuestionsError));
      }
    });

    on<TextQuestionChangedValueAction>((event, emit) {
      emit(state.copyWith(isLoading: true, onError: null));
      final textAnswer = state.answerList!.firstWhere((answer) => answer.questionId == event.questionId, orElse: () => Answer(questionId: event.questionId));
      final answerIndex = state.answerList!.indexOf(textAnswer);
      textAnswer.text = event.text;
      if (answerIndex == -1) {
        state.answerList!.add(textAnswer);
      } else {
        state.answerList!.replaceRange(answerIndex, answerIndex + 1, [textAnswer]);
      }
      emit(state.copyWith(isLoading: false, onError: null));
      }
    );
  }

}