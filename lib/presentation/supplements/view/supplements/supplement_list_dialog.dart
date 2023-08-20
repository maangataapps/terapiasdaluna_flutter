import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/dialog_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/widgets/no_events_card.dart';
import 'package:terapiasdaluna/presentation/widgets/supplement_activation_item_list.dart';

class SupplementListDialog extends StatefulWidget {
  final List<Supplement> supplementsList;
  final Function onClickSupplement;
  final Function onFinish;

  const SupplementListDialog({
    super.key,
    required this.supplementsList,
    required this.onClickSupplement,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _SupplementListDialogState();
}

class _SupplementListDialogState extends State<SupplementListDialog> {

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: DialogTitle(
        title: AppLocalizations.of(context)!.supplement_list,
        color: AppColors.supplementsColor,
      ),
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
            child: widget.supplementsList.isNotEmpty
                ? Column(
              children: [
                ...widget.supplementsList.map((supplement) => SupplementActivationItemList(
                  supplement: supplement,
                  onClickSupplement: (bool value, Supplement supplement) => widget.onClickSupplement(value, supplement),
                ),).toList()
              ],
            )
                : NoEventsCard(color: AppColors.supplementsColor, message: AppLocalizations.of(context)!.no_supplements_message),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: buttonStyle(color: MaterialStateProperty.all(AppColors.supplementsColor)),
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.exit),
          ),
        ),
      ],
    );
  }

}