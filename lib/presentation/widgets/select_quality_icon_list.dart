import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';
import 'package:terapiasdaluna/infrastructure/helpers/questions_helper.dart';

class SelectQualityItemList extends StatefulWidget {
  final int? quality;
  final Function? onSelect;
  final bool isTouchEnabled;
  final IconData icon;
  final MaterialColor color;
  final int questionId;

  const SelectQualityItemList({
    super.key,
    this.quality,
    this.onSelect,
    required this.isTouchEnabled,
    required this.icon,
    required this.color,
    required this.questionId,
  });

  @override
  State<StatefulWidget> createState() => _SelectQualityItemListState();

}

class _SelectQualityItemListState extends State<SelectQualityItemList> {
  int? quality;
  List<IconData> iconList = [];

  @override
  Widget build(BuildContext context) {
    if (iconList.isEmpty) {
      iconList = [
        widget.icon,
        widget.icon,
        widget.icon,
      ];

      if (QuestionsHelper().isFiveStarsQuestion(widget.questionId)) {
        iconList.addAll([
          widget.icon,
          widget.icon,
        ]);
      }
    }

    if (widget.isTouchEnabled) {
      quality ??= widget.quality;
    } else {
      quality = widget.quality;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...iconList.mapIndexed((index, icon) {
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
              child: Icon(
                icon as IconData,
                size: 30,
                color: quality == null || quality! < index ? Colors.grey : widget.color,
              ),
            ),
          );
        })
      ],
    );
  }
  
}