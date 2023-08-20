class QuestionsActions {
  QuestionsActions();
}

class InitializeStateAction extends QuestionsActions {
  InitializeStateAction();
}

class SelectQualityAction extends QuestionsActions {
  final int questionId;
  final int quality;

  SelectQualityAction({required this.questionId, required this.quality});
}

class FinishQuestionsAction extends QuestionsActions {
  final Function onFinish;

  FinishQuestionsAction({required this.onFinish});
}

class TextQuestionChangedValueAction extends QuestionsActions {
  final int questionId;
  final String text;

  TextQuestionChangedValueAction({required this.questionId, required this.text});
}