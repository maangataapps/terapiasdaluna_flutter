import 'package:flutter/material.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_resolver.dart';
import 'package:terapiasdaluna/infrastructure/utils/app_colors.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/utils/validator_utils.dart';

class ForgottenPasswordDialog extends StatefulWidget {
  final Function onAccept;
  final Function onReject;

  const ForgottenPasswordDialog({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<StatefulWidget> createState() => _ForgottenPasswordDialogState();

}

class _ForgottenPasswordDialogState extends State<ForgottenPasswordDialog> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          AppLocalizations.of(context)!.forgotten_password_title,
          style: const TextStyle(
            fontSize: Dimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginNormal),
          child: Text(
            AppLocalizations.of(context)!.forgotten_password_info,
            overflow: TextOverflow.clip,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(Dimens.marginNormal),
          child: Form(
            key: _formKey,
            child: TextFormField(

              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
                suffixIcon: IconButton(
                  icon: _emailController.text != ''
                      ? const Icon(
                    Icons.highlight_remove,
                    color: Colors.teal,
                  )
                      : Container(),
                  onPressed: () => setState(() {
                    _emailController.text = '';
                  }),
                ),
              ),
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  _emailController;
                });
              },
              validator: (value) => resolveFormError(context, validateEmail(value)),
            ),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onAccept.call(_emailController.text);
                }
              },
              child: Text(
                AppLocalizations.of(context)!.accept,
              ),
            ),
          ],
        )
      ],
    );
  }

}