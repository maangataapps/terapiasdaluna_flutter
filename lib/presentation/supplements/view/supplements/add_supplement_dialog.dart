import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/supplements/view/supplements/add_supplement_content.dart';
import 'package:terapiasdaluna/presentation/widgets/dialog_title.dart';

class AddSupplementDialog extends StatefulWidget {
  final bool isEdit;
  final String? id;
  final String? name;
  final Dose? dose;
  final int? intakeForm;
  final int? quantityPerBox;
  final int? quantityPerTake;
  final IntakesTimes? intakesTimes;
  final bool? outOfMeals;
  final Function onFinish;

  const AddSupplementDialog({
    super.key,
    required this.isEdit,
    required this.id,
    required this.name,
    required this.dose,
    required this.intakeForm,
    required this.quantityPerBox,
    required this.quantityPerTake,
    required this.intakesTimes,
    required this.outOfMeals,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddSupplementDialogState();

}

class _AddSupplementDialogState extends State<AddSupplementDialog> {

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: DialogTitle(
        title: widget.isEdit ? AppLocalizations.of(context)!.edit_supplement : AppLocalizations.of(context)!.add_new_supplement,
        color: AppColors.supplementsColor,
      ),
      children: [
        // if (widget.isEdit && !addNewSupplement) AddSupplementContent(
        if (widget.isEdit) AddSupplementContent(
              isEdit: widget.isEdit,
              eventId: widget.id,
              name: widget.name,
              dose: widget.dose,
              intakeForm: widget.intakeForm,
              quantityPerBox: widget.quantityPerBox,
              quantityPerTake: widget.quantityPerTake,
              intakesTimes: widget.intakesTimes,
              outOfMeals: widget.outOfMeals,
              onFinish: widget.onFinish,
            ),
        // if (!widget.isEdit && addNewSupplement) AddSupplementContent(
        if (!widget.isEdit) AddSupplementContent(
          isEdit: widget.isEdit,
          onFinish: widget.onFinish,
        ),
      ],
    );
  }

}