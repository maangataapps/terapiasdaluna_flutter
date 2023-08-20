import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/helpers/questions_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/questions/model/question_ui.dart';
import 'package:terapiasdaluna/presentation/widgets/select_quality_icon_list.dart';

class ChooseNumberQuestionItemList extends StatefulWidget {
  final QuestionUI question;
  final Function onQualityChosen;

  const ChooseNumberQuestionItemList({
    super.key,
    required this.question,
    required this.onQualityChosen,
  });

  @override
  State<StatefulWidget> createState() => _ChooseNumberQuestionItemListState();

}

class _ChooseNumberQuestionItemListState extends State<ChooseNumberQuestionItemList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.question.hasBeenAnswered ? Colors.green : Colors.red,
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
              QuestionsHelper.getQuestionTitle(widget.question.question),
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: Dimens.fontSizeLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: Dimens.marginNormal,
              vertical: Dimens.marginNormal,
            ),
            child: SelectQualityItemList(
              color: AppColors.questionsColor,
              icon: Icons.star,
              isTouchEnabled: true,
              onSelect: (int quality) => widget.onQualityChosen(widget.question.question.id, quality),
            ),
          )
        ],
      ),
    );
  }

}