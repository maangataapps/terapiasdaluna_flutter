import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';

class AddFoodEventDialog extends StatefulWidget {
  final bool isEdit;
  final String textInfo;
  final DateTime eventDate;
  final Function onFinish;
  final String title;
  final String hint;
  final dateTimeHelper = DateTimeHelper();

  AddFoodEventDialog({
    super.key,
    required this.isEdit,
    required this.textInfo,
    required this.eventDate,
    required this.onFinish,
    required this.title,
    required this.hint,
  });

  @override
  State<StatefulWidget> createState() => _AddFoodEventDialogState();
}

class _AddFoodEventDialogState extends State<AddFoodEventDialog> {
  final _textController = TextEditingController();
  final dateTimeHelper = DateTimeHelper();
  DateTime? chosenDate;

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit && _textController.text.isEmpty) _textController.text = widget.textInfo;
    chosenDate ??= widget.eventDate;

    return SimpleDialog(
      shadowColor: AppColors.foodColor,
      elevation: 8,
      surfaceTintColor: AppColors.foodColor,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.foodColor,
        child: Text(
          widget.title,
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
                      labelText: widget.hint,
                      suffixIcon: IconButton(
                        icon: _textController.text != ''
                            ? const Icon(
                          Icons.highlight_remove,
                          color: AppColors.foodColor,
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
                    },
                  ),
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
                          color: AppColors.foodColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: buttonStyle(color: MaterialStateProperty.all(AppColors.foodColor)),
                    onPressed: () {
                      if (_textController.text == '') {
                        showSnackBarError(context, AppLocalizations.of(context)!.missing_info_error);
                      } else {
                        widget.onFinish.call(
                          _textController.text,
                          chosenDate!.millisecondsSinceEpoch,
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