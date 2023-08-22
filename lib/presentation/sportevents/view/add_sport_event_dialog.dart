import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';

class AddSportEventDialog extends StatefulWidget {
  final bool isEdit;
  final String textInfo;
  final DateTime eventDate;
  final Function onFinish;
  final int? duration;
  final dateTimeHelper = DateTimeHelper();

  AddSportEventDialog({
    super.key,
    required this.isEdit,
    required this.textInfo,
    required this.eventDate,
    required this.onFinish,
    this.duration,
  });

  @override
  State<StatefulWidget> createState() => _AddSportEventDialogState();
}

class _AddSportEventDialogState extends State<AddSportEventDialog> {
  final _textController = TextEditingController();
  final _durationTextController = TextEditingController();
  final dateTimeHelper = DateTimeHelper();
  bool _deletedText = false;
  DateTime? chosenDate;

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit && _textController.text.isEmpty && !_deletedText) _textController.text = widget.textInfo;
    if (widget.isEdit && widget.duration != null && _durationTextController.text.isEmpty) _durationTextController.text = widget.duration.toString();
    chosenDate ??= widget.eventDate;

    return SimpleDialog(
      shadowColor: AppColors.sportColor,
      elevation: 8,
      surfaceTintColor: AppColors.sportColor,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.sportColor,
        child: Text(
          !widget.isEdit ? AppLocalizations.of(context)!.add_sport_event : AppLocalizations.of(context)!.edit_sport,
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.sport_event_hint,
                      suffixIcon: IconButton(
                        icon: _textController.text != ''
                            ? const Icon(
                          Icons.highlight_remove,
                          color: AppColors.sportColor,
                        )
                            : Container(),
                        onPressed: () => setState(() {
                          _textController.text = '';
                          _deletedText = true;
                        }),
                      ),
                    ),
                    controller: _textController,
                    onChanged: (value) {
                      setState(() {
                        _textController;
                        _deletedText = false;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: Dimens.marginNormal),
                        child: Text(
                          '${AppLocalizations.of(context)!.duration}:',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _durationTextController,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppLocalizations.of(context)!.minutes.toLowerCase(),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: Dimens.marginNormal),
                      alignment: Alignment.center,
                      child: Text(
                        dateTimeHelper.formatSelectedEventDate(chosenDate!.millisecondsSinceEpoch, Localizations.localeOf(context).languageCode),
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
                              DatePickerHelper.presentTimePicker(context: context, saveDate: (TimeOfDay pickedTime) {
                                setState(() {
                                  chosenDate = chosenDate!.copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
                                });
                              },);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.calendar_month_sharp,
                          color: AppColors.sportColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: buttonStyle(color: MaterialStateProperty.all(AppColors.sportColor)),
                    onPressed: () {
                      if (_textController.text == '' || _durationTextController.text == '') {
                        showSnackBarError(context, AppLocalizations.of(context)!.missing_info_error);
                      } else {
                        widget.onFinish.call(
                          _textController.text,
                          chosenDate!.millisecondsSinceEpoch,
                          int.parse(_durationTextController.text),
                              () => Navigator.pop(context),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }

}