import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/helpers/supplements_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/intake_times_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupplementListItem extends StatelessWidget {
  final Supplement supplement;
  final Function onEdit;
  final Function onDelete;
  final supplementHelper = SupplementsHelper();

  SupplementListItem({
    super.key,
    required this.supplement,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.supplementsColor,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
                  child: Text(
                    supplementHelper.getSupplementCompleteName(context, supplement),
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimens.fontSizeNormal,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
                  child: Text(
                    supplementHelper.getSupplementQuantityPerTake(context, supplement.quantityPerTake, supplementHelper.getIntakeFormFromIndex(supplement.intakeForm)),
                  ),
                ),
                if (supplement.outOfMeals) Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginSmall),
                  child: Text(
                    AppLocalizations.of(context)!.out_of_meals,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.marginSmall, bottom: Dimens.marginNormal),
                  child: IntakeTimesBox(
                    intakesTimes: supplement.intakesTimes,
                    isEditable: false,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => onEdit.call(),
              icon: const Icon(
                Icons.edit,
                color: AppColors.supplementsColor,
              ),
            ),
          )
        ],
      ),
    );
  }

}