import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/constants.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/sleep_quality.dart';

class AddSleepEventDialog extends StatefulWidget {
  final bool isEdit;
  final int? quality;
  final int? hours;
  final int? minutes;
  final DateTime eventDate;
  final Function onFinish;

  const AddSleepEventDialog({
    super.key,
    required this.isEdit,
    required this.quality,
    required this.hours,
    required this.minutes,
    required this.eventDate,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddSleepEventDialogState();
}

class _AddSleepEventDialogState extends State<AddSleepEventDialog> {
  final dateTimeHelper = DateTimeHelper();
  DateTime? chosenDate;
  int? quality;
  int? hours;
  int? minutes;

  @override
  Widget build(BuildContext context) {
    quality ??= widget.quality;
    hours ??= widget.hours;
    minutes ??= widget.minutes;
    chosenDate ??= widget.eventDate;

    return SimpleDialog(
      shadowColor: AppColors.sleepColor,
      elevation: 8,
      surfaceTintColor: AppColors.sleepColor,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.sleepColor,
        child: Text(
          !widget.isEdit ? AppLocalizations.of(context)!.add_sleep_event : AppLocalizations.of(context)!.edit_sleep,
          style: const TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      children: [
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.sleep_quality_question,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimens.marginNormal,
                  ),
                  child: SleepQuality(
                    quality: widget.quality,
                    isTouchEnabled: true,
                    onSelect: (int qualitySelected) => setState(() => quality = qualitySelected),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.sleep_duration_question,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: Dimens.marginNormal, bottom: Dimens.marginNormal),
                        alignment: Alignment.center,
                        child: Text(
                          '- ${AppLocalizations.of(context)!.hours} -',
                        ),
                      ),
                      NumberPicker(
                        minValue: Constants.SLEEP_HOURS_MIN,
                        maxValue: Constants.SLEEP_HOURS_MAX,
                        value: hours!,
                        axis: Axis.horizontal,
                        step: 1,
                        textStyle: const TextStyle(
                          fontSize: Dimens.fontSizeNormal,
                          color: AppColors.sleepColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.sleepColor),
                        ),
                        onChanged: (hoursSelected) {
                          setState(() => hours = hoursSelected);
                        },
                      ),
                    ],
                  ),

                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: Dimens.marginNormal, bottom: Dimens.marginNormal),
                        alignment: Alignment.center,
                        child: Text(
                          '- ${AppLocalizations.of(context)!.minutes} -',
                        ),
                      ),
                      NumberPicker(
                        minValue: Constants.SLEEP_MINUTES_MIN,
                        maxValue: Constants.SLEEP_MINUTES_MAX,
                        value: minutes!,
                        axis: Axis.horizontal,
                        step: 1,
                        textStyle: const TextStyle(
                          fontSize: Dimens.fontSizeNormal,
                          color: AppColors.sleepColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.sleepColor),
                        ),
                        onChanged: (minutesSelected) => setState(() => minutes = minutesSelected),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal),
                      alignment: Alignment.center,
                      child: Text(
                        dateTimeHelper.formatSelectedEventDateOnlyDay(chosenDate!.millisecondsSinceEpoch, Localizations.localeOf(context).languageCode),
                        style: const TextStyle(
                          fontSize: Dimens.fontSizeLarge,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: Dimens.marginNormal),
                      child: IconButton(
                        alignment: Alignment.center,
                        iconSize: 45,
                        onPressed: () {
                          DatePickerHelper.presentDatePicker(
                            context: context,
                            saveDate: (DateTime dateTime) {
                              setState(() {
                                chosenDate = dateTime;
                              });
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.calendar_month_sharp,
                          color: AppColors.sleepColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: buttonStyle(color: MaterialStateProperty.all(AppColors.sleepColor)),
                    onPressed: () {
                      if (quality != null) {
                        widget.onFinish.call(
                          quality,
                          dateTimeHelper.getMillisecondsFromHourAndMinute(hours!, minutes!),
                          chosenDate!.millisecondsSinceEpoch,
                              () => Navigator.pop(context),
                        );
                      } else {
                        showSnackBarError(context, AppLocalizations.of(context)!.not_selected_sleep_quality);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

}