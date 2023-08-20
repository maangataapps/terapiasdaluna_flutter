import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditionsDialog extends StatefulWidget {
  final Function onAccept;
  final Function onReject;

  const TermsAndConditionsDialog({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<StatefulWidget> createState() => _TermsAndConditionsDialogState();

}

class _TermsAndConditionsDialogState extends State<TermsAndConditionsDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SimpleDialog(
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.adminColor,
        child: Text(
          AppLocalizations.of(context)!.terms_and_conditions,
          style: const TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      children: [
        Container(
          margin: const EdgeInsets.all(Dimens.marginNormal),
          height: size.height/2,
          child: SingleChildScrollView(
            child: Text(
              AppLocalizations.of(context)!.terms_and_conditions_text,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all(Colors.teal),
                checkColor: Colors.teal,
                side: const BorderSide(width: 1, color: AppColors.poopColor,),
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.accept_terms_and_conditions)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                AppLocalizations.of(context)!.cancel,
              ),
              onPressed: () => widget.onReject.call(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: _isChecked ? () => widget.onAccept.call() : null,
              child: Text(
                AppLocalizations.of(context)!.accept,
              ),
            ),
          ],
        ),
      ],
    );
  }

}