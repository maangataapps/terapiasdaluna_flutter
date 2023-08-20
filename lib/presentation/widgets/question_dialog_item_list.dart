import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/questions_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/select_quality_icon_list.dart';

class QuestionDialogItemList extends StatelessWidget {
  final AnsweredQuestion answeredQuestion;

  const QuestionDialogItemList({
    super.key,
    required this.answeredQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.questionsColor,
      elevation: 4,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: Dimens.marginNormal,
              vertical: Dimens.marginNormal,
            ),
            child: Text(
              QuestionsHelper.getQuestionFromAnsweredQuestion(answeredQuestion.questionId),
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: Dimens.fontSizeLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          answeredQuestion.quality != null
              ? Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: SelectQualityItemList(
                    quality: answeredQuestion.quality,
                    color: AppColors.questionsColor,
                    icon: Icons.star,
                    isTouchEnabled: false,
                  ),
                )
              : Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Text(
                    answeredQuestion.text.orEmpty(),
                  ),
                )
        ],
      ),
    );
  }

}