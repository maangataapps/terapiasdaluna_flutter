import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/locale_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/presentation/widgets/event_list_buttons.dart';
import 'package:terapiasdaluna/presentation/widgets/sleep_quality.dart';


class SleepEventItemList extends StatelessWidget {
  final int eventDate;
  final int duration;
  final int quality;
  final Function onEdit;
  final Function onDelete;
  final DateTimeHelper dateTimeHelper = DateTimeHelper();

  SleepEventItemList({
    super.key,
    required this.eventDate,
    required this.duration,
    required this.quality,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.sleepColor,
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
                    dateTimeHelper.formatHourMinuteFromInt(
                      duration,
                      AppLocalizations.of(context)!.hours.toLowerCase(),
                      AppLocalizations.of(context)!.minutes.toLowerCase(),
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: SleepQuality(
                    quality: quality,
                    isTouchEnabled: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.marginXLarge, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
                  child: Text(
                    '${dateTimeHelper.formatSelectedEventDate(eventDate, getLocale(context))}.',
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
              color: AppColors.sleepColor,
              onEdit: onEdit,
              onDelete: onDelete,
            ),
          )
        ],
      ),
    );
  }

}