import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_picker_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/date_time_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/intake_time_segment.dart';

class IntakeTimesBox extends StatefulWidget {
  final IntakesTimes intakesTimes;
  final bool isEditable;
  final double? boxHeight;
  final double? timesHeight;
  final color = AppColors.supplementsColor;

  const IntakeTimesBox({
    super.key,
    required this.intakesTimes,
    required this.isEditable,
    this.boxHeight,
    this.timesHeight,
  });

  @override
  State<StatefulWidget> createState() => _IntakeTimesBoxState();

}

class _IntakeTimesBoxState extends State<IntakeTimesBox> {
  IntakesTimes? _intakeTimes;
  final _dateTimeHelper = DateTimeHelper();

  void showTimePickerForIntakeTime(IntakeTime intakeTime) {
    if (intakeTime.isTakingIt) {
      DatePickerHelper.presentTimePicker(
        context: context,
        saveDate: (TimeOfDay pickedTime) {
          setState(() {
            intakeTime.exactTime = _dateTimeHelper.formatHourMinuteFromTimeOfDay(context, pickedTime);
          });
        },
      );
    }
  }

  void onIntakeTimePressed(IntakeTime intakeTime) {
    intakeTime.isTakingIt = !intakeTime.isTakingIt;
    if (intakeTime.isTakingIt) {
      showTimePickerForIntakeTime(intakeTime);
    } else {
      intakeTime.exactTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _intakeTimes ??= widget.intakesTimes;

    Widget morningBox = IntakeTimeSegment(
      color: widget.color,
      title: AppLocalizations.of(context)!.morning,
      isTakingIt: widget.intakesTimes.morning.isTakingIt,
      border: Border(
        left: BorderSide(
          color: widget.color,
          width: 1,
        ),
        top: BorderSide(
          color: widget.color,
          width: 1,
        ),
        bottom: BorderSide(
          color: widget.color,
          width: 1,
        ),
        right: BorderSide(
          color: widget.color,
          width: 0,
        ),
      ),
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
    );

    Widget lunchBox = IntakeTimeSegment(
      title: AppLocalizations.of(context)!.lunch,
      color: widget.color,
      isTakingIt: widget.intakesTimes.lunch.isTakingIt,
      border: Border(
        left: BorderSide(
          color: widget.intakesTimes.lunch.isTakingIt ? Colors.white : widget.color,
          width: 1,
        ),
        top: BorderSide(
          color: widget.color,
          width: 1,
        ),
        bottom: BorderSide(
          color: widget.color,
          width: 1,
        ),
        right: BorderSide(
          color: widget.intakesTimes.lunch.isTakingIt ? Colors.white : widget.color,
          width: 1,
        ),
      ),
    );

    Widget dinnerBox = IntakeTimeSegment(
      title: AppLocalizations.of(context)!.dinner,
      isTakingIt: widget.intakesTimes.dinner.isTakingIt,
      color: widget.color,
      border: Border(
        left: BorderSide(
          color: widget.color,
          width: 0,
        ),
        top: BorderSide(
          color: widget.color,
          width: 1,
        ),
        bottom: BorderSide(
          color: widget.color,
          width: 1,
        ),
        right: BorderSide(
          color: widget.intakesTimes.dinner.isTakingIt ? Colors.white : widget.color,
          width: 1,
        ),
      ),
    );

    Widget nightBox = IntakeTimeSegment(
      title: AppLocalizations.of(context)!.night,
      isTakingIt: widget.intakesTimes.night.isTakingIt,
      color: widget.color,
      border: Border(
        left: BorderSide(
          color: widget.color,
          width: 0,
        ),
        top: BorderSide(
          color: widget.color,
          width: 1,
        ),
        bottom: BorderSide(
          color: widget.color,
          width: 1,
        ),
        right: BorderSide(
          color: widget.color,
          width: 1,
        ),
      ),
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
    );

    return Column(
      children: [
        SizedBox(
          height: widget.boxHeight,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: widget.isEditable
                    ? SizedBox(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
                    onTap: () => setState(() => onIntakeTimePressed(_intakeTimes!.morning)),
                    child: morningBox,
                  ),
                )
                    : morningBox,
              ),
              Expanded(
                flex: 1,
                child: widget.isEditable
                    ? SizedBox(
                  child: InkWell(
                    onTap: () => setState(() =>  onIntakeTimePressed(_intakeTimes!.lunch)),
                    child: lunchBox,
                ),
                    )
                : lunchBox,
              ),
              Expanded(
                flex: 1,
                child: widget.isEditable
                    ? SizedBox(
                  child: InkWell(
                    onTap: () => setState(() =>  onIntakeTimePressed(_intakeTimes!.dinner)),
                    child: dinnerBox,
                  ),
                    )
                    : dinnerBox,
              ),
              Expanded(
                flex: 1,
                child: widget.isEditable
                    ? SizedBox(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
                    onTap: () => setState(() =>  onIntakeTimePressed(_intakeTimes!.night)),
                    child: nightBox,
                  ),
                    )
                    : nightBox,
              ),
            ],
          ),
        ),
        if (widget.isEditable) SizedBox(
          height: widget.timesHeight,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    _intakeTimes!.morning.exactTime.orEmpty(),
                    style: const TextStyle(
                        fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    _intakeTimes!.lunch.exactTime.orEmpty(),
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    _intakeTimes!.dinner.exactTime.orEmpty(),
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    _intakeTimes!.night.exactTime.orEmpty(),
                    style: const TextStyle(
                      fontSize: Dimens.fontSizeLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}