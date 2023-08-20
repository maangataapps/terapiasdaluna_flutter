import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/infrastructure/errors/error_types.dart';

String resolveError(BuildContext context, ErrorTypes errorType) {
  final stringResolver = AppLocalizations.of(context)!;

  return switch (errorType) {
    ErrorTypes.unknownError => stringResolver.unknown_error,
    ErrorTypes.weakPasswordError => stringResolver.weak_password_error,
    ErrorTypes.userCreationNull => stringResolver.user_not_created_error,
    ErrorTypes.emailAlreadyInUseError => stringResolver.unknown_error,
    ErrorTypes.uploadProfileError => stringResolver.unknown_error,
    ErrorTypes.signInError => stringResolver.unknown_error,
    ErrorTypes.hasToAnswerAllQuestionsError => stringResolver.has_to_answer_all_questions_error,
    ErrorTypes.errorSavingEvent => stringResolver.saving_event_error,
    ErrorTypes.heightError => stringResolver.height_error,
    ErrorTypes.weightError => stringResolver.weight_error,
    ErrorTypes.birthDateError => stringResolver.birth_date_error,
    ErrorTypes.sexError => stringResolver.sex_error,
  };
}

String? resolveFormError(BuildContext context, FormErrorTypes? formErrorTypes) {
  if (formErrorTypes == null) return null;
  final stringResolver = AppLocalizations.of(context)!;

  switch (formErrorTypes) {
    case FormErrorTypes.usernameEmptyOrNullError:
      return stringResolver.username_empty_or_null_error;
    case FormErrorTypes.emailFormatError:
      return stringResolver.email_format_error;
    case FormErrorTypes.invalidPasswordError:
      return stringResolver.invalid_password_error;
    case FormErrorTypes.emptyRepeatPassword:
      return stringResolver.empty_repeat_password;
    case FormErrorTypes.repeatPasswordError:
      return stringResolver.repeat_password_error;
  }
}
