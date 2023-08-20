import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/choose_supplement_item_list.dart';
import 'package:terapiasdaluna/presentation/widgets/dialog_title.dart';

class AddSupplementEventDialog extends StatefulWidget {
  final bool isEdit;
  final List<Supplement> supplementList;
  final SupplementEvent? supplementEvent;
  final Function onFinish;

  const AddSupplementEventDialog({
    super.key,
    required this.isEdit,
    required this.supplementList,
    this.supplementEvent,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddSupplementEventDialog();
}

class _AddSupplementEventDialog extends State<AddSupplementEventDialog> {
  Supplement? _selectedSupplement;
  DateTime? _chosenDate;
  final DateTimeHelper _dateTimeHelper = DateTimeHelper();

  @override
  Widget build(BuildContext context) {
    if (_selectedSupplement == null && widget.supplementEvent != null) {
      _selectedSupplement = widget.supplementList.firstWhere((supplement) => supplement.id == widget.supplementEvent!.supplementId);
    }
    if (_chosenDate == null) {
      if (widget.isEdit) {
        _chosenDate = _dateTimeHelper.setDateFromMilliseconds(widget.supplementEvent!.intakeTime);
      } else {
        _chosenDate = _dateTimeHelper.provideCurrentDate();
      }
    }

    return SimpleDialog(
      title: DialogTitle(
        title: AppLocalizations.of(context)!.add_new_supplement_event,
        color: AppColors.supplementsColor,
      ),
      children: [
        Column(
          children: [
            ...widget.supplementList.map((supplement) => ChooseSupplementItemList(
              isSelected: _selectedSupplement == supplement,
              supplement: supplement,
              onSupplementClicked: (Supplement supplement) {
                setState(() => _selectedSupplement = supplement,);
              },
            ),),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.marginLarge),
                    child: Text(
                      _dateTimeHelper.formatSelectedEventDate(_chosenDate!.millisecondsSinceEpoch, getLocale(context)),
                      style: const TextStyle(
                        fontSize: Dimens.fontSizeLarge,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 45,
                    icon: const Icon(
                      Icons.calendar_month_sharp,
                      color: AppColors.supplementsColor,
                    ),
                    onPressed: () {
                      DatePickerHelper.presentDatePicker(
                        context: context,
                        saveDate: (DateTime dateTime) {
                          setState(() {
                            _chosenDate = dateTime;
                          });
                          DatePickerHelper.presentTimePicker(context: context, saveDate: (TimeOfDay pickedTime) {
                            setState(() {
                              _chosenDate = _chosenDate!.copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
                            });
                          },);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: buttonStyle(color: MaterialStateProperty.all(AppColors.supplementsColor)),
                onPressed: () {
                  if (_selectedSupplement == null) {
                    // TODO: usar los error types en toda la app.
                    showSnackBarError(context, AppLocalizations.of(context)!.not_selected_supplement_error);
                  } else {
                    widget.onFinish.call(_selectedSupplement, _chosenDate, widget.supplementEvent?.eventId);
                  }
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
          ],
        )
      ],
    );
  }
}