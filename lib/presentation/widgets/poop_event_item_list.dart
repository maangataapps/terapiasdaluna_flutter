import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/event_list_buttons.dart';

class PoopEventItemList extends StatelessWidget {
  final int eventDate;
  final int poopType;
  final bool abdominalPain;
  final bool flatulence;
  final Function onEdit;
  final Function onDelete;
  final DateTimeHelper dateTimeHelper = DateTimeHelper();

  PoopEventItemList({
    super.key,
    required this.eventDate,
    required this.poopType,
    required this.abdominalPain,
    required this.flatulence,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.poopColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: Dimens.marginNormal, top: Dimens.marginNormal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${AppLocalizations.of(context)!.stool_type.appendColon()} ${poopType+1}',
                      style: const TextStyle(
                        fontSize: Dimens.fontSizeLarge,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                    child: Text(
                      '${DateTimeHelper().formatSelectedEventDate(eventDate, getLocale(context))}.',
                      style: const TextStyle(
                        fontSize: Dimens.fontSizeNormal,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: EventListButtons(
              color: AppColors.poopColor,
              onEdit: onEdit,
              onDelete: onDelete,
            ),
          )
        ],
      ),
    );
  }

}