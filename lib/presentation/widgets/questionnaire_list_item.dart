import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionnaireListItem extends StatelessWidget {
  final AnsweredQuestionnaire questionnaire;
  final Function onEyeClick;

  const QuestionnaireListItem({
    super.key,
    required this.questionnaire,
    required this.onEyeClick
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.questionsColor,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal),
                  child: Text(
                    AppLocalizations.of(context)!.questionnaire,
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: Dimens.marginNormal, right: Dimens.marginNormal, bottom: Dimens.marginNormal, ),
                  child: Text(DateTimeHelper().formatSelectedEventDate(questionnaire.eventDate, getLocale(context))),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => onEyeClick.call(),
              icon: const Icon(
                Icons.remove_red_eye,
                color: AppColors.questionsColor,
              ),
            ),
          )
        ],
      ),
    );
  }

}