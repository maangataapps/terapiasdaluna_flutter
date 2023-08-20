import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/helpers/events_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/dashboard/model/reminder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderItemList extends StatelessWidget {
  final Reminder reminder;
  final Function onClickedSave;
  final _eventsHelper = EventsHelper();

  ReminderItemList({
    super.key,
    required this.reminder,
    required this.onClickedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: reminder.hasBeenTaken ? Colors.green : Colors.red,
      child: Opacity(
        opacity: reminder.hasBeenTaken ? 0.4 : 1,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              reminder.supplementEvent.name,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              _eventsHelper.getTimeOfIntakeName(context, reminder.supplementEvent.timeOfSupplement!),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: reminder.hasBeenTaken ? null : () => onClickedSave.call(),
                    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.green,),
                  ),
                )
              ],
            ),
            if (reminder.supplementEvent.outOfMeals) Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                left: Dimens.marginLarge,
                right: Dimens.marginNormal,
                bottom: Dimens.marginNormal,
              ),
              child: Text(
                AppLocalizations.of(context)!.out_of_meals,

              ),
            )
          ],
        ),
      ),
    );
  }

}