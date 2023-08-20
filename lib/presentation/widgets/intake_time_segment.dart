import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class IntakeTimeSegment extends StatelessWidget {
  final String title;
  final bool isTakingIt;
  final Color color;
  final Border border;
  final BorderRadiusGeometry? borderRadius;

  const IntakeTimeSegment({
    super.key,
    required this.title,
    required this.isTakingIt,
    required this.color,
    required this.border,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isTakingIt ? color : Colors.transparent,
        borderRadius: borderRadius,
        border: border,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isTakingIt ? Colors.white : color,
          fontSize: Dimens.fontSizeNormal,
        ),
      ),
    );
  }

}