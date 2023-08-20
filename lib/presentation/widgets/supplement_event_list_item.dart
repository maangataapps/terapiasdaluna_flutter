import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/event_list_buttons.dart';

class SupplementEventListItem extends StatelessWidget {
  final SupplementEvent supplementEvent;
  final Function onEditSupplementEvent;
  final Function onDeleteSupplementEvent;
  final bool isCalendar;

  const SupplementEventListItem({
    super.key,
    required this.supplementEvent,
    required this.onEditSupplementEvent,
    required this.onDeleteSupplementEvent,
    this.isCalendar = false,
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
                  margin: const EdgeInsets.only(left: Dimens.marginNormal, top: Dimens.marginNormal),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    supplementEvent.name,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                      fontWeight: isCalendar ? null : FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: isCalendar ? Alignment.centerLeft : Alignment.center,
                  margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: Text(
                    DateTimeHelper().formatSelectedEventDate(supplementEvent.intakeTime, getLocale(context)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: EventListButtons(
              color: AppColors.supplementsColor,
              onEdit: onEditSupplementEvent,
              onDelete: onDeleteSupplementEvent,
              showEdit: false,
            ),
          )
        ],
      ),
    );
  }

}