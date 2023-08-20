import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';

class PoopTypeItem extends StatefulWidget {
  final String image;
  final String description;
  final Function onCheckedChange;
  final bool isChecked;

  const PoopTypeItem({
    super.key,
    required this.image,
    required this.description,
    required this.onCheckedChange,
    required this.isChecked,
  });

  @override
  State<StatefulWidget> createState() => _PoopTypeItemState();
}

class _PoopTypeItemState extends State<PoopTypeItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    isChecked = widget.isChecked;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              widget.image,
              height: 30,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.description,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            fillColor: MaterialStateProperty.all(AppColors.poopColor),
            checkColor: AppColors.poopColor,
            side: const BorderSide(width: 1, color: AppColors.poopColor,),
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
                widget.onCheckedChange.call();
              });
            },
          ),
        ),
      ],
    );
  }

}