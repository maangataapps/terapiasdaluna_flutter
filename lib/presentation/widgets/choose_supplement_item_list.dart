import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/helpers/supplements_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:terapiasdaluna/presentation/widgets/radio_button.dart';

class ChooseSupplementItemList extends StatefulWidget {
  final bool isSelected;
  final Supplement supplement;
  final Function onSupplementClicked;

  const ChooseSupplementItemList({
    super.key,
    required this.isSelected,
    required this.supplement,
    required this.onSupplementClicked,
  });
  
  @override
  State<StatefulWidget> createState() => _ChooseSupplementItemListState();
  
}

class _ChooseSupplementItemListState extends State<ChooseSupplementItemList> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.isSelected;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.marginLarge),
      child: InkWell(
        highlightColor: AppColors.supplementsColor[100],
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onSupplementClicked.call(widget.supplement);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimens.marginSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _isSelected ? AppColors.supplementsColor : Colors.transparent,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: RadioButton(isSelected: _isSelected),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  SupplementsHelper().getSupplementCompleteName(context, widget.supplement),
                  style: TextStyle(
                    color: _isSelected ? Colors.white : Colors.black,
                    fontSize: Dimens.fontSizeLarge,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}