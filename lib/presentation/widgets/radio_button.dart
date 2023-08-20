import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class RadioButton extends StatefulWidget {
  final bool isSelected;

  const RadioButton({
    super.key,
    required this.isSelected,
  });

  @override
  State<StatefulWidget> createState() => _RadioButton();

}

class _RadioButton extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: Dimens.marginNormal),
      child: Container(
        height: 21,
        width: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: Dimens.borderSmall,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

}