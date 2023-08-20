import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/foodevents/food_events.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_events.dart';
import 'package:terapiasdaluna/domain/model/questions/answered_questionnaire.dart';
import 'package:terapiasdaluna/domain/model/sleepevents/sleep_events.dart';
import 'package:terapiasdaluna/domain/model/sportevents/sport_events.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/supplements_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/constants.dart';
import 'package:terapiasdaluna/presentation/dashboard/view/log_out_dialog.dart';
import 'package:terapiasdaluna/presentation/foodevents/view/add_food_event_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/login/view/forgotten_password_dialog.dart';
import 'package:terapiasdaluna/presentation/login/view/terms_and_conditions_dialog.dart';
import 'package:terapiasdaluna/presentation/poopevents/view/add_poop_event_dialog.dart';
import 'package:terapiasdaluna/presentation/questions/view/questionnaire_dialog.dart';
import 'package:terapiasdaluna/presentation/sleepevents/view/add_sleep_event_dialog.dart';
import 'package:terapiasdaluna/presentation/sportevents/view/add_sport_event_dialog.dart';
import 'package:terapiasdaluna/presentation/supplements/view/events/add_supplement_event_from_dashboard_dialog.dart';
import 'package:terapiasdaluna/presentation/supplements/view/supplements/add_supplement_dialog.dart';
import 'package:terapiasdaluna/presentation/supplements/view/events/add_supplement_event_dialog.dart';
import 'package:terapiasdaluna/presentation/supplements/view/supplements/supplement_list_dialog.dart';

class DialogHelper {

  void showAddFoodDialog({required BuildContext context, required Function onFinish, FoodEvent? foodEvent}) {
    final textInfo = foodEvent?.foodInfo ?? '';
    final DateTimeHelper dateTimeHelper = DateTimeHelper();
    DateTime eventDate = foodEvent != null
        ? dateTimeHelper.setDateFromMilliseconds(foodEvent.eventDate)
        : dateTimeHelper.provideCurrentDate();

    showDialog(
      context: context,
      builder: (ctx) {
        return AddFoodEventDialog(
          isEdit: foodEvent != null,
          textInfo: textInfo,
          eventDate: eventDate,
          onFinish: (String info, int date, Function onPressedFinish) => onFinish.call(info, date, onPressedFinish),
          title: foodEvent == null ? AppLocalizations.of(context)!.add_food_event : AppLocalizations.of(context)!.edit_food,
          hint: AppLocalizations.of(context)!.food_event_hint,
        );
      },
    );
  }

  void showAddPoopDialog({
    required BuildContext context,
    required Function onFinish,
    PoopEvent? poopEvent,
  }) {
    final DateTimeHelper dateTimeHelper = DateTimeHelper();
    DateTime? chosenDate = poopEvent != null
        ? dateTimeHelper.setDateFromMilliseconds(poopEvent.eventDate)
        : dateTimeHelper.provideCurrentDate();

    showDialog(
      context: context,
      builder: (ctx) {
        return AddPoopEventDialog(
          eventDate: chosenDate,
          isEdit: poopEvent != null,
          poopType: poopEvent?.poopType,
          abdominalPain: poopEvent?.abdominalPain,
          flatulence: poopEvent?.flatulence,
          onFinish: onFinish,
        );
      },
    );
  }

  void showAddSleepDialog({
    required BuildContext context,
    required Function onFinish,
    SleepEvent? sleepEvent,
  }) {
    final DateTimeHelper dateTimeHelper = DateTimeHelper();
    DateTime? chosenDate = sleepEvent != null
        ? dateTimeHelper.setDateFromMilliseconds(sleepEvent.eventDate)
        : dateTimeHelper.provideCurrentDate();
    int? quality = sleepEvent?.quality;
    int hours = sleepEvent != null ? dateTimeHelper.getHoursFromMilliseconds(sleepEvent.sleepTime) : Constants.SLEEP_HOURS_INITIAL;
    int minutes = sleepEvent != null ? dateTimeHelper.getMinutesFromMilliseconds(sleepEvent.sleepTime) : Constants.SLEEP_MINUTES_INITIAL;

    showDialog(
      context: context,
      builder: (ctx) {
        return AddSleepEventDialog(
          eventDate: chosenDate,
          quality: quality,
          hours: hours,
          minutes: minutes,
          isEdit: sleepEvent != null,
          onFinish: onFinish,
        );
      },
    );
  }

  void showAddSportDialog({required BuildContext context, required Function onFinish, SportEvent? sportEvent}) {
    final textInfo = sportEvent?.sportInfo ?? '';
    final DateTimeHelper dateTimeHelper = DateTimeHelper();
    DateTime eventDate = sportEvent != null
        ? dateTimeHelper.setDateFromMilliseconds(sportEvent.eventDate)
        : dateTimeHelper.provideCurrentDate();

    showDialog(
      context: context,
      builder: (ctx) {
        return AddSportEventDialog(
          isEdit: sportEvent != null,
          textInfo: textInfo,
          eventDate: eventDate,
          onFinish: (String info, int date, int duration, Function onPressedFinish) => onFinish.call(
            info,
            date,
            duration,
            onPressedFinish,
          ),
          duration: sportEvent?.duration,
        );
      },
    );
  }

  void showAddSupplementDialog({
    required BuildContext context,
    required Function onFinish,
    Supplement? supplement,
  }) {
    final id = supplement?.id;
    final name = supplement?.name;
    final dose = supplement?.dose;
    final intakeForm = supplement?.intakeForm;
    final quantityPerBox = supplement?.quantityPerBox;
    final quantityPerTake = supplement?.quantityPerTake;
    final intakesTimes = supplement?.intakesTimes ?? SupplementsHelper().getEmptyIntakesTimes();
    final outOfMeals = supplement?.outOfMeals ?? false;

    showDialog(
      context: context,
      builder: (ctx) {
        return AddSupplementDialog(
          isEdit: supplement != null,
          id: id,
          name: name,
          dose: dose,
          intakeForm: intakeForm,
          quantityPerBox: quantityPerBox,
          quantityPerTake: quantityPerTake,
          intakesTimes: intakesTimes,
          outOfMeals: outOfMeals,
          onFinish: onFinish,
        );
      },
    );
  }

  void showAddSupplementEventDialog({
    required BuildContext context,
    required List<Supplement> supplementList,
    SupplementEvent? supplementEvent,
    required Function onFinish,
  }) {

    showDialog(
      context: context,
      builder: (ctx) {
        return AddSupplementEventDialog(
          isEdit: supplementEvent != null,
          supplementList: supplementList,
          supplementEvent: supplementEvent,
          onFinish: onFinish,
        );
      },
    );
  }

  void showAddSupplementEventFromDashboardDialog({
    required BuildContext context,
    required SupplementEvent supplementEvent,
    required Function onFinish,
  }) {

    showDialog(
      context: context,
      builder: (ctx) {
        return AddSupplementEventFromDashboardDialog(
          supplementEvent: supplementEvent,
          onFinish: onFinish,
        );
      },
    );
  }

  void showSupplementsListDialog({
    required BuildContext context,
    required List<Supplement> supplementList,
    required Function onClickSupplement,
    required Function onFinish,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SupplementListDialog(
          supplementsList: supplementList,
          onClickSupplement: onClickSupplement,
          onFinish: onFinish,
        );
      },
    );
  }

  void showQuestionnaireDialog({
    required BuildContext context,
    required AnsweredQuestionnaire questionnaire,
    required Function onFinish,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return QuestionnaireDialog(
          questionnaire: questionnaire,
        );
      },
    );
  }

  void showLogOutDialog(BuildContext context, {required Function onFinish}) {
    showDialog(context: context, builder: (ctx) {
      return LogOutDialog(
        onFinish: onFinish,
      );
    },);
  }

  void showTermsAndConditionsDialog(BuildContext context, {
    required Function onAccept,
    required Function onReject,
  }) {
    showDialog(context: context, builder: (ctx) {
      return TermsAndConditionsDialog(
        onAccept: onAccept,
        onReject: onReject,
      );
    },);
  }

  void showForgottenPasswordDialog(BuildContext context, {required Function onAccept, required Function onReject}) {
    showDialog(context: context, builder: (ctx) {
      return ForgottenPasswordDialog(
        onAccept: onAccept,
        onReject: onReject,
      );
    },);
  }

}