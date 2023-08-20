import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class EventListButtons extends StatelessWidget {
  final Color color;
  final Function onEdit;
  final Function onDelete;
  final bool showEdit;

  const EventListButtons({
    super.key,
    required this.color,
    required this.onEdit,
    required this.onDelete,
    this.showEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dimens.marginNormal),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showEdit) IconButton(
            onPressed: () => onEdit.call(),
            icon: Icon(
              Icons.edit,
              color: color,
            ),
          ),
          IconButton(
            onPressed: () => onDelete.call(),
            icon: Icon(
              Icons.delete,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

}