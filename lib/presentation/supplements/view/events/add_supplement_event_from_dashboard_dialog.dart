import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';
import 'package:terapiasdaluna/presentation/widgets/dialog_title.dart';

class AddSupplementEventFromDashboardDialog extends StatefulWidget {
  final SupplementEvent supplementEvent;
  final Function onFinish;

  const AddSupplementEventFromDashboardDialog({
    super.key,
    required this.supplementEvent,
    required this.onFinish,
  });

  @override
  State<StatefulWidget> createState() => _AddSupplementEventFromDashboardDialogState();

}

class _AddSupplementEventFromDashboardDialogState extends State<AddSupplementEventFromDashboardDialog> {

  @override
  Widget build(BuildContext context) {

    return SimpleDialog(
      title: DialogTitle(
        title: AppLocalizations.of(context)!.add_new_supplement_event,
        color: AppColors.supplementsColor,
      ),
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.marginXXLarge),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.supplementEvent.name,
                      style: const TextStyle(
                        fontSize: Dimens.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        EventsHelper().getTimeOfIntakeName(context, widget.supplementEvent.timeOfSupplement!),
                        style: const TextStyle(
                          fontSize: Dimens.fontSizeLarge,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: Dimens.marginLarge),
              child: ElevatedButton(
                style: buttonStyle(color: MaterialStateProperty.all(AppColors.supplementsColor)),
                onPressed: () => widget.onFinish.call(),
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
          ],
        )
      ],
    );
  }

}