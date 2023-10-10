import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

class SupplementsActions {
  SupplementsActions();
}

class InitializeStateAction extends SupplementsActions {
  InitializeStateAction();
}

class SaveSupplementAction extends SupplementsActions {
  final Supplement supplement;
  final Function onFinish;

  SaveSupplementAction({required this.supplement, required this.onFinish});
}

class ChangeSupplementActivationStateAction extends SupplementsActions {
  final bool isActivated;
  final Supplement supplement;

  ChangeSupplementActivationStateAction({required this.isActivated, required this.supplement});
}

class EditSupplementAction extends SupplementsActions {
  final Supplement supplement;
  final Function onFinish;

  EditSupplementAction({required this.supplement, required this.onFinish});
}

class EditSupplementEventAction extends SupplementsActions {
  final Supplement supplement;
  final DateTime chosenDate;
  final String? eventId;
  final Function onFinish;

  EditSupplementEventAction({
    required this.supplement,
    required this.chosenDate,
    this.eventId,
    required this.onFinish,
  });
}

class DeleteSupplementEventAction extends SupplementsActions {
  final SupplementEvent supplementEvent;

  DeleteSupplementEventAction({required this.supplementEvent});
}

class SaveSupplementEventAction extends SupplementsActions {
  final Supplement supplement;
  final DateTime chosenDate;
  final Function onFinish;

  SaveSupplementEventAction({required this.supplement, required this.chosenDate, required this.onFinish});
}