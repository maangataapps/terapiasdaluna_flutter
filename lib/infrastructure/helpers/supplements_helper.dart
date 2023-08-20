import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/infrastructure/extensions/extensions.dart';

class SupplementsHelper {

  SupplementsHelper();

  String getSupplementCompleteName(BuildContext context, Supplement supplement) {
    return '${supplement.name.firstLetterToUpperCase()} ${_getSupplementDoseName(context, supplement.dose)}';
  }

  String _getSupplementDoseName(BuildContext context, Dose dose) {
    switch (dose.unit) {
      case Unit.ml: return '${dose.dose} ${AppLocalizations.of(context)!.ml}';
      case Unit.mg: return '${dose.dose} ${AppLocalizations.of(context)!.mg}';
      case Unit.microg: return '${dose.dose} ${AppLocalizations.of(context)!.microg}';
      case Unit.UI: return '${dose.dose} ${AppLocalizations.of(context)!.ui}';
      case Unit.g: return '${dose.dose} ${AppLocalizations.of(context)!.g}';
      case Unit.mgml: return '${dose.dose} ${AppLocalizations.of(context)!.mgml}';
    }
  }
  
  String getUnitName(BuildContext context, Unit unit) {
    switch (unit) {
      case Unit.ml: return AppLocalizations.of(context)!.ml;
      case Unit.mg: return AppLocalizations.of(context)!.mg;
      case Unit.microg: return AppLocalizations.of(context)!.microg;
      case Unit.UI: return AppLocalizations.of(context)!.ui;
      case Unit.g: return AppLocalizations.of(context)!.g;
      case Unit.mgml: return AppLocalizations.of(context)!.mgml;
    }
  }

  String getSupplementQuantityPerTake(BuildContext context, int quantityPerTake, IntakeForm intakeForm) {
    return '$quantityPerTake ${getSupplementIntakeFormName(context, intakeForm)} ${AppLocalizations.of(context)!.per_take}';
  }

  String getSupplementIntakeFormName(BuildContext context, IntakeForm intakeForm) {
    switch (intakeForm) {
      case IntakeForm.pill: return AppLocalizations.of(context)!.pill;
      case IntakeForm.capsule: return AppLocalizations.of(context)!.capsule;
      case IntakeForm.spoon: return AppLocalizations.of(context)!.spoon;
      case IntakeForm.vial: return AppLocalizations.of(context)!.vial;
      case IntakeForm.drop: return AppLocalizations.of(context)!.drop;
    }
  }

  List<Unit> getUnitsList() => Unit.values;
  List<IntakeForm> getFormsList() => IntakeForm.values;

  IntakesTimes getEmptyIntakesTimes() => IntakesTimes(
      morning: IntakeTime.empty(),
      lunch: IntakeTime.empty(),
      dinner: IntakeTime.empty(),
      night: IntakeTime.empty(),
  );

  Unit? findUnitByName(BuildContext context, String unitName) {
    if (unitName == Unit.mg.name) {
      return Unit.mg;
    } else if (unitName == Unit.ml.name) {
      return Unit.ml;
    } else if (unitName == Unit.microg.name) {
      return Unit.microg;
    } else if (unitName == Unit.UI.name) {
      return Unit.UI;
    } else if (unitName == Unit.g.name) {
      return Unit.g;
    } else if (unitName == Unit.mgml.name) {
      return Unit.mgml;
    } else {
      return null;
    }
  }

  IntakeForm? findIntakeFormByName(BuildContext context, String formName) {
    final stringResolver = AppLocalizations.of(context)!;
    if (formName == stringResolver.pill.toString()) {
      return IntakeForm.pill;
    } else if (formName == stringResolver.capsule) {
      return IntakeForm.capsule;
    } else if (formName == stringResolver.spoon) {
      return IntakeForm.spoon;
    } else if (formName == stringResolver.vial) {
      return IntakeForm.vial;
    } else if (formName == stringResolver.drop) {
      return IntakeForm.drop;
    } else {
      return null;
    }
  }

  IntakeForm getIntakeFormFromIndex(int index) {
    switch (index) {
      case 0: return IntakeForm.pill;
      case 1: return IntakeForm.capsule;
      case 2: return IntakeForm.spoon;
      case 3: return IntakeForm.vial;
      case 4: return IntakeForm.drop;
      default: return IntakeForm.pill;
    }
  }

  Unit getUnitFromIndex(int index) {
    switch (index) {
      case 0: return Unit.ml;
      case 1: return Unit.mg;
      case 2: return Unit.microg;
      case 3: return Unit.UI;
      case 4: return Unit.g;
      case 5: return Unit.mgml;
      default: return Unit.mg;
    }
  }
}