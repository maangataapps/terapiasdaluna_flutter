import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/snack_bar_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/supplements_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/general_text_field.dart';
import 'package:terapiasdaluna/presentation/widgets/intake_times_box.dart';

class AddSupplementContent extends StatefulWidget {
  final bool isEdit;
  final String? eventId;
  final String? name;
  final Dose? dose;
  final int? intakeForm;
  final int? quantityPerBox;
  final int? quantityPerTake;
  final IntakesTimes? intakesTimes;
  final bool? outOfMeals;
  final Function onFinish;

  const AddSupplementContent({
    super.key,
    required this.isEdit,
    this.eventId,
    this.name,
    this.dose,
    this.intakeForm,
    this.quantityPerBox,
    this.quantityPerTake,
    this.intakesTimes,
    this.outOfMeals,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddSupplementContentState();
}

class _AddSupplementContentState extends State<AddSupplementContent> {
  final _supplementNameController = TextEditingController();
  final _concentrationController = TextEditingController();
  final _quantityPerBoxController = TextEditingController();
  final _quantityPerTakeController = TextEditingController();
  String? _unitName;
  String? _formName;
  IntakesTimes? _intakeTimes;
  List<Unit> units = SupplementsHelper().getUnitsList();
  List<IntakeForm> forms = SupplementsHelper().getFormsList();
  bool? _outOfMeals;
  final _supplementsHelper = SupplementsHelper();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit && _supplementNameController.text.isEmpty) _supplementNameController.text = widget.name.orEmpty();
    if (widget.isEdit && _concentrationController.text.isEmpty && widget.dose != null) _concentrationController.text = widget.dose!.dose.toString();
    if (widget.isEdit && _quantityPerBoxController.text.isEmpty) _quantityPerBoxController.text = widget.quantityPerBox.toString();
    if (widget.isEdit && _quantityPerTakeController.text.isEmpty) _quantityPerTakeController.text = widget.quantityPerTake.toString();
    if (widget.isEdit && _unitName == null && widget.dose != null) _unitName = widget.dose?.unit.name;
    if (widget.isEdit && _formName == null && widget.intakeForm != null) _formName = _supplementsHelper.getSupplementIntakeFormName(context, _supplementsHelper.getIntakeFormFromIndex(widget.intakeForm!));
    if (_intakeTimes == null) {
      if (widget.intakesTimes == null) {
        _intakeTimes = _supplementsHelper.getEmptyIntakesTimes();
      } else {
        _intakeTimes = widget.intakesTimes;
      }
    }
    if (widget.isEdit && _outOfMeals == null) {
      _outOfMeals = widget.outOfMeals;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
          child: GeneralTextField(
            color: AppColors.supplementsColor,
            controller: _supplementNameController,
            labelText: AppLocalizations.of(context)!.enter_supplement_name,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GeneralTextField(
                        color: AppColors.supplementsColor,
                        controller: _concentrationController,
                        labelText: AppLocalizations.of(context)!.concentration,
                        textInputType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.unit,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        underline: Container(height: 1, color: AppColors.supplementsColor,),
                        value: _unitName,
                        onChanged: (String? unit) {
                          setState(() {
                            _unitName = unit!;
                          });
                        },
                        items: units.map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
                          value: item.name,
                          child: SizedBox(
                            child: Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: Dimens.fontSizeNormal,
                              ),
                            ),
                          ),),
                        ).toList(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  AppLocalizations.of(context)!.pharmaceutical_form_question,
                  style: const TextStyle(
                    color: AppColors.supplementsColor,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: Container(height: 1, color: AppColors.supplementsColor,),
                    value: _formName,
                    isExpanded: true,
                    onChanged: (String? form) => setState(() => _formName = form!),
                    items: forms.map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
                      value: _supplementsHelper.getSupplementIntakeFormName(context, item),
                      child: SizedBox(
                        child: Text(
                          _supplementsHelper.getSupplementIntakeFormName(context, item).firstLetterToUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimens.fontSizeNormal,
                          ),
                        ),
                      ),),
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.marginNormal,
            vertical: Dimens.marginSmall,
          ),
          child: IntakeTimesBox(
            boxHeight: 38,
            timesHeight: 20,
            isEditable: true,
            intakesTimes: _intakeTimes!,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.marginNormal,
            vertical: Dimens.marginSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.out_of_meals),
              Checkbox(
                value: _outOfMeals,
                onChanged: (value) => setState(() => _outOfMeals = value),
                fillColor: MaterialStateProperty.all(AppColors.supplementsColor),
                checkColor: AppColors.supplementsColor,
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
          child: GeneralTextField(
            labelText: AppLocalizations.of(context)!.quantity_per_box_question,
            controller: _quantityPerBoxController,
            color: AppColors.supplementsColor,
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
          child: GeneralTextField(
            labelText: AppLocalizations.of(context)!.quantity_per_take_question,
            controller: _quantityPerTakeController,
            color: AppColors.supplementsColor,
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: buttonStyle(color: MaterialStateProperty.all(AppColors.supplementsColor)),
            onPressed: () {
              if (_supplementNameController.text != '' &&
                  _concentrationController.text != '' &&
                  _unitName != null &&
                  _formName != null &&
                  _quantityPerTakeController.text != '' &&
                  _quantityPerBoxController.text != ''
              ) {
                final supplement = Supplement(
                  id: widget.eventId ?? DateTimeHelper().provideCurrentDate().millisecondsSinceEpoch.toString(),
                  name: _supplementNameController.text,
                  dose: Dose(
                    dose: int.parse(_concentrationController.text),
                    unit: _supplementsHelper.findUnitByName(context, _unitName.orEmpty())!,
                  ),
                  intakeForm: _supplementsHelper.findIntakeFormByName(context, _formName.orEmpty())!.index,
                  quantityPerBox: int.parse(_quantityPerBoxController.text),
                  quantityPerTake: int.parse(_quantityPerTakeController.text),
                  intakesTimes: _intakeTimes!,
                  isActivated: true,
                  outOfMeals: _outOfMeals!,
                );
                widget.onFinish.call(supplement, () => Navigator.pop(context));
              } else {
                showSnackBarError(context, AppLocalizations.of(context)!.add_supplement_error);
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ),
      ],
    );
  }
}