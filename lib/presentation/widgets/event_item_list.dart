import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/event_list_buttons.dart';

class EventItemList extends StatelessWidget {
  final String title;
  final int dateTime;
  final Function onEdit;
  final Function onDelete;
  final Color eventTypeColor;
  final int? duration;

  const EventItemList({
    super.key,
    required this.title,
    required this.dateTime,
    required this.onEdit,
    required this.onDelete,
    required this.eventTypeColor,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: eventTypeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: Dimens.marginNormal, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: Text(
                    title,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
                if (duration != null) Container(
                  margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: Text(
                    '$duration ${AppLocalizations.of(context)!.minutes.toLowerCase()}',
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeNormal,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: Text(
                    '${DateTimeHelper().formatSelectedEventDate(dateTime, getLocale(context))}.',
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeNormal,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: EventListButtons(
              color: eventTypeColor,
              onEdit: onEdit,
              onDelete: onDelete,
            ),
          )
        ],
      ),
    );
  }

}