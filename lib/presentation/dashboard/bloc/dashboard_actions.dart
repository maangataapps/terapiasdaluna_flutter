import 'package:terapiasdaluna/domain/model/supplements/supplement_event.dart';

class DashboardActions {
  DashboardActions();
}

class InitializeStateAction extends DashboardActions {
  InitializeStateAction();
}

class SaveSupplementEventFromDashboardAction extends DashboardActions {
  final SupplementEvent supplementEvent;
  final Function onFinish;

  SaveSupplementEventFromDashboardAction({required this.supplementEvent, required this.onFinish});
}

class PerformLogOutAction extends DashboardActions {
  final Function onFinish;

  PerformLogOutAction({required this.onFinish});
}