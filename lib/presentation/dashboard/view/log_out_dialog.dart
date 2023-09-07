import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/utils/widget_utils.dart';

class LogOutDialog extends StatelessWidget {
  final Function onFinish;

  const LogOutDialog({
    super.key,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal, vertical: Dimens.marginNormal,),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal, vertical: Dimens.paddingNormal,),
        color: AppColors.adminColor,
        child: Text(
          AppLocalizations.of(context)!.log_out,
          style: const TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.marginNormal,
            vertical: Dimens.marginNormal,
          ),
          child: Text(
            AppLocalizations.of(context)!.log_out_question,
            style: const TextStyle(
              fontSize: Dimens.fontSizeLarge,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.marginNormal,
            vertical: Dimens.marginNormal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: buttonStyle(color: MaterialStateProperty.all(Colors.teal)),
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: buttonStyle(color: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                    onFinish.call();
                  },
                  child: Text(AppLocalizations.of(context)!.log_out),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}