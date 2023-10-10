import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/helpers/supplements_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class SupplementActivationItemList extends StatefulWidget {
  final Supplement supplement;
  final Function onClickSupplement;

  const SupplementActivationItemList({
    super.key,
    required this.supplement,
    required this.onClickSupplement,
  });

  @override
  State<StatefulWidget> createState() => _SupplementActivationItemListState();

}

class _SupplementActivationItemListState extends State<SupplementActivationItemList> {
  bool _isActivated = false;

  @override
  Widget build(BuildContext context) {
    _isActivated = widget.supplement.isActivated;

    return Card(
      elevation: 4,
      shadowColor: AppColors.supplementsColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: Dimens.marginNormal, top: Dimens.marginSmall, bottom: Dimens.marginSmall),
              child: Text(
                SupplementsHelper().getSupplementCompleteName(context, widget.supplement),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Switch(
              value: _isActivated,
              onChanged: (bool value) {
                setState(() {
                  _isActivated = value;
                });
                widget.onClickSupplement.call(value, widget.supplement);
              },
            ),
          )
        ],
      ),
    );
  }

}