import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class DialogTitle extends StatelessWidget {
  final String title;
  final Color color;

  const DialogTitle({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
      color: color,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: Dimens.fontSizeLarge,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

}