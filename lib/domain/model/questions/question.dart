import 'package:terapiasdaluna/infrastructure/helpers/i10n_helper.dart';

class Question {
  int id;
  String title;
  QuestionType questionType;

  Question({
    required this.id,
    required this.title,
    required this.questionType,
  });

}

class Question1 extends Question {
  Question1() : super(
    id: 0,
    title: AppLocalizationsHelper.instance.translate('question1'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question2 extends Question {
  Question2() : super(
    id: 1,
    title: AppLocalizationsHelper.instance.translate('question2'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question3 extends Question {
  Question3() : super(
    id: 2,
    title: AppLocalizationsHelper.instance.translate('question3'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question4 extends Question {
  Question4() : super(
    id: 3,
    title: AppLocalizationsHelper.instance.translate('question4'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question5 extends Question {
  Question5() : super(
    id: 4,
    title: AppLocalizationsHelper.instance.translate('question5'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question6 extends Question {
  Question6() : super(
    id: 5,
    title: AppLocalizationsHelper.instance.translate('question6'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question7 extends Question {
  Question7() : super(
    id: 6,
    title: AppLocalizationsHelper.instance.translate('question7'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question8 extends Question {
  Question8() : super(
    id: 7,
    title: AppLocalizationsHelper.instance.translate('question8'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question9 extends Question {
  Question9() : super(
    id: 8,
    title: AppLocalizationsHelper.instance.translate('question9'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question10 extends Question {
  Question10() : super(
    id: 9,
    title: AppLocalizationsHelper.instance.translate('question10'),
    questionType: QuestionType.chooseNumber,
  );
}

class Question11 extends Question {
  Question11() : super(
    id: 10,
    title: AppLocalizationsHelper.instance.translate('question11'),
    questionType: QuestionType.text,
  );
}

enum QuestionType {
  chooseNumber, text
}