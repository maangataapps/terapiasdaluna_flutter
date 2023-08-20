import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class DotsInCalendarWidget extends StatelessWidget {
  final bool foodEvents;
  final bool sportEvents;
  final bool sleepEvents;
  final bool poopEvents;
  final bool supplementEvents;
  final bool questionnaires;

  const DotsInCalendarWidget({
    super.key,
    required this.foodEvents,
    required this.sportEvents,
    required this.sleepEvents,
    required this.poopEvents,
    required this.supplementEvents,
    required this.questionnaires,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 6,
                width: 6,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: foodEvents ? AppColors.foodColor : Colors.transparent,
                ),
              ),
              Container(
                height: 6,
                width: 6,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: sportEvents ? AppColors.sportColor : Colors.transparent,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: Dimens.marginXSmall),
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: supplementEvents ? AppColors.supplementsColor : Colors.transparent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: Dimens.marginXSmall),
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: questionnaires ? AppColors.questionsColor : Colors.transparent,
                  ),
                ),
              ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sleepEvents ? AppColors.sleepColor : Colors.transparent,
                ),
              ),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: poopEvents ? AppColors.poopColor : Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}