import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class NoEventsCard extends StatelessWidget {
  final MaterialColor color;
  final String message;

  const NoEventsCard({
    super.key,
    required this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.marginXLarge),
      alignment: Alignment.center,
      child: Card(
        elevation: 4,
        shadowColor: color,
        child: Container(
          margin: const EdgeInsets.all(Dimens.marginXLarge),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Dimens.fontSizeLarge,
            ),
          ),
        ),
      ),
    );
  }

}