import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/poopevents/poop_type.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/poop_type_item.dart';

class AddPoopEventDialog extends StatefulWidget {
  final bool isEdit;
  final DateTime eventDate;
  final int? poopType;
  final bool? abdominalPain;
  final bool? flatulence;
  final Function onFinish;

  const AddPoopEventDialog({
    super.key,
    required this.isEdit,
    required this.eventDate,
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddPoopEventDialogState();
}

class _AddPoopEventDialogState extends State<AddPoopEventDialog> {
  final dateTimeHelper = DateTimeHelper();
  final poopTypes = PoopType.createPoopTypesList();
  DateTime? chosenDate;
  int? selectedPoopType;
  bool? abdominalPain;
  bool? flatulence;

  @override
  Widget build(BuildContext context) {
    chosenDate ??= widget.eventDate;
    selectedPoopType ??= widget.poopType;
    abdominalPain = widget.abdominalPain ?? false;
    flatulence = widget.flatulence ?? false;

    return SimpleDialog(
      shadowColor: AppColors.poopColor,
      elevation: 8,
      surfaceTintColor: AppColors.poopColor,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.poopColor,
        child: Text(
          !widget.isEdit ? AppLocalizations.of(context)!.add_poop_event : AppLocalizations.of(context)!.edit_poop,
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
                    AppLocalizations.of(context)!.poop_type_question,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimens.marginNormal,
                  ),
                  child: Column(
                    children: [
                      ...poopTypes.map((poopType) => Container(
                        decoration: BoxDecoration(
                          border: poopType.index == selectedPoopType ? Border.all(color: AppColors.poopColor, width: 1, style: BorderStyle.solid) : null,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.only(left: Dimens.marginNormal, bottom: Dimens.marginNormal, right: Dimens.marginNormal),
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginSmall, vertical: Dimens.marginSmall),
                        child: PoopTypeItem(
                          description: poopType.description,
                          image: poopType.image,
                          isChecked: poopType.index == selectedPoopType,
                          onCheckedChange: () => setState(() => selectedPoopType = poopType.index),
                        ),
                      ),).toList()
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          AppLocalizations.of(context)!.abdominal_pain_question,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: abdominalPain ?? false,
                          onChanged: (bool? value) => setState(() => abdominalPain = value),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginNormal,
                    vertical: Dimens.marginNormal,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          AppLocalizations.of(context)!.gases_question,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: flatulence ?? false,
                          onChanged: (bool? value) => setState(() => flatulence = value),
                        ),
                      )
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
                          color: AppColors.poopColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: buttonStyle(color: MaterialStateProperty.all(AppColors.poopColor)),
                    onPressed: () {
                      if (selectedPoopType != null) {
                        widget.onFinish.call(
                          selectedPoopType,
                          abdominalPain,
                          flatulence,
                          chosenDate!.millisecondsSinceEpoch,
                              () => Navigator.pop(context),
                        );
                      } else {
                        showSnackBarError(context, AppLocalizations.of(context)!.not_selected_poop_type);
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