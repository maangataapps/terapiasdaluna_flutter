import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class SplashRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String imagePath;
  final Color? backgroundColor;
  final double? iconSize;
  final MaterialColor splashColor;
  final double? splashRadius;

  const SplashRoundedButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
    this.backgroundColor,
    this.iconSize,
    required this.splashColor,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.marginNormal),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.transparent,
      ),
      child: IconButton(
        splashRadius: splashRadius,
        highlightColor: splashColor,
        icon: Image.asset(imagePath),
        iconSize: iconSize,
        splashColor: splashColor,
        onPressed: () => onPressed.call(),
      ),
    );
  }

}