import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terapiasdaluna/domain/model/questions/question.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/base/view/loading_screen.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_actions.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_bloc.dart';
import 'package:terapiasdaluna/presentation/questions/bloc/questions_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/widgets/choose_number_question_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/text_question_item_list.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = 'questions';

  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();

}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    final bloc = BlocProvider.of<QuestionsBloc>(context);
    bloc.add(InitializeStateAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuestionsBloc>(context);

    return BlocProvider.value(
      value: bloc,
      child: SafeArea(
        child: BlocConsumer<QuestionsBloc, QuestionsState>(
          listener: (ctx, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: ctx,
                text: AppLocalizations.of(ctx)!.loading,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            if (state.onError != null) {
              showSnackBarError(context, resolveError(ctx, state.onError!));
            }
          },
          builder: (ctx, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.questionsColor,
                title: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.questions,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // TODO: controlar el tipo de pregunta, porque según sea una u otra el elemento visual a cargar es otro.
                    ...state.questionsList!.map((questionUI) {
                      if (questionUI.question.questionType == QuestionType.text) {
                        return TextQuestionItemList(
                          questionUI: questionUI, 
                          onTextChanged: (String value) => bloc.add(TextQuestionChangedValueAction(questionId: questionUI.question.id, text: value)),
                        );
                      } else {
                        return ChooseNumberQuestionItemList(
                          question: questionUI,
                          onQualityChosen: (int questionId, int quality,) => bloc.add(SelectQualityAction(questionId: questionId, quality: quality)),
                        );
                      }
                    }).toList()
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.questionsColor,
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => bloc.add(FinishQuestionsAction(onFinish: () => Navigator.pop(context))),
              ),
            );
          },
        ),
      ),
    );
  }

}