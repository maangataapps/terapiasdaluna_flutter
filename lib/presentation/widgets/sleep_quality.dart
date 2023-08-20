import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';

class SleepQuality extends StatefulWidget {
  final int? quality;
  final Function? onSelect;
  final bool isTouchEnabled;

  const SleepQuality({
    super.key,
    required this.quality,
    this.onSelect,
    required this.isTouchEnabled,
  });

  @override
  State<StatefulWidget> createState() => _SleepQualityState();
}

class _SleepQualityState extends State<SleepQuality> {
  final moonList = [
   ImageHelper().moonImage,
   ImageHelper().moonImage,
   ImageHelper().moonImage,
   ImageHelper().moonImage,
   ImageHelper().moonImage,
  ];
  int? quality;

  @override
  Widget build(BuildContext context) {
    if (widget.isTouchEnabled) {
      quality ??= widget.quality;
    } else {
      quality = widget.quality;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...moonList.mapIndexed((index, moon) {
          return GestureDetector(
            onTap: () {
              if (widget.isTouchEnabled) {
                setState(() {
                  quality = index;
                });
                widget.onSelect?.call(quality);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                moon as String,
                color: quality == null || quality! < index ? Colors.grey : AppColors.sleepColor,
                width: 30,
                height: 30,
              ),
            ),
          );
        })
      ],
    );
  }
}