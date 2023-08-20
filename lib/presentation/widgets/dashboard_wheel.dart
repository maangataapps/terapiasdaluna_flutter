import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/presentation/widgets/splash_rounded_button.dart';

class DashboardWheel extends StatefulWidget {
  final double width;
  final Function onClickFoods;
  final Function onClickSports;
  final Function onClickSleep;
  final Function onClickPoopsies;
  final Function onClickCalendar;

  const DashboardWheel({
    Key? key,
    required this.width,
    required this.onClickFoods,
    required this.onClickSports,
    required this.onClickSleep,
    required this.onClickPoopsies,
    required this.onClickCalendar,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardWheelState();

}

class _DashboardWheelState extends State<DashboardWheel> {
  final imageHelper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Card(
        shape: const CircleBorder(),
        shadowColor: AppColors.adminColor,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SplashRoundedButton(
                onPressed: () => widget.onClickSports.call(),
                imagePath: imageHelper.sportImage,
                iconSize: widget.width/7,
                splashColor: AppColors.sportColor,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: widget.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: SplashRoundedButton(
                          onPressed: () => widget.onClickSleep.call(),
                          imagePath: imageHelper.sleepImage,
                          iconSize: widget.width/7,
                          splashColor: AppColors.sleepColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        shadowColor: AppColors.calendarColor,
                        shape: const CircleBorder(),
                        child: Container(
                          alignment: Alignment.center,
                          child: SplashRoundedButton(
                            onPressed: () => widget.onClickCalendar.call(),
                            imagePath: imageHelper.calendarImage,
                            iconSize: widget.width/7,
                            splashColor: AppColors.calendarColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: SplashRoundedButton(
                          onPressed: () => widget.onClickPoopsies.call(),
                          imagePath: imageHelper.poopImage,
                          iconSize: widget.width/7,
                          splashColor: Colors.brown,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: SplashRoundedButton(
                  onPressed: () => widget.onClickFoods.call(),
                  imagePath: imageHelper.foodImage,
                  iconSize: widget.width/7,
                  splashColor: AppColors.foodColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}