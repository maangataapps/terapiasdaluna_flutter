import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/helpers/questions_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/questions/model/question_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextQuestionItemList extends StatefulWidget {
  final QuestionUI questionUI;
  final Function onTextChanged;

  const TextQuestionItemList({
    super.key,
    required this.questionUI,
    required this.onTextChanged,
  });

  @override
  State<StatefulWidget> createState() => _TextQuestionItemListState();

}

class _TextQuestionItemListState extends State<TextQuestionItemList> {
  final _textController = TextEditingController();

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
              QuestionsHelper.getQuestionTitle(widget.questionUI.question),
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
            child: TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.text_question_hint,
                suffixIcon: IconButton(
                  icon: _textController.text != ''
                      ? const Icon(
                    Icons.highlight_remove,
                    color: AppColors.questionsColor,
                  )
                      : Container(),
                  onPressed: () => setState(() {
                    _textController.text = '';
                  }),
                ),
              ),
              controller: _textController,
              onChanged: (value) {
                setState(() {
                  _textController;
                });
                widget.onTextChanged.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }

}