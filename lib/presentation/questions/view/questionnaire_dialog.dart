import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/question_dialog_item_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionnaireDialog extends StatelessWidget {
  final AnsweredQuestionnaire questionnaire;

  const QuestionnaireDialog({
    super.key,
    required this.questionnaire,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.questionsColor,
        child: Text(
          AppLocalizations.of(context)!.questionnaire,
          style: const TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      children: [
        Column(
          children: [
            ...questionnaire.answers.map((answeredQuestion) => QuestionDialogItemList(answeredQuestion: answeredQuestion))
          ],
        ),
      ],
    );
  }

}