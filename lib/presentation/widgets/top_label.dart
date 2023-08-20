import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class TopLabel extends StatelessWidget {
  final MaterialColor backgroundColor;
  final Color textColor;
  final String label;

  const TopLabel({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.only(
            left: Dimens.marginLarge,
            right: Dimens.marginLarge,
            top: Dimens.marginXSmall,
            bottom: Dimens.marginSmall,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSizeLarge,
            ),
          ),
        ),
      ),
    );
  }

}