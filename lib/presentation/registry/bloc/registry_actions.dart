import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

class RegistryActions {
  RegistryActions();
}

class InitializeStateAction extends RegistryActions {
  InitializeStateAction();
}

class SetBirthdateAction extends RegistryActions {
  final DateTime birthdate;

  SetBirthdateAction({required this.birthdate});
}

class SetSexAction extends RegistryActions {
  final SexType sexType;

  SetSexAction({required this.sexType});
}

class SetHeightAction extends RegistryActions {
  final int height;

  SetHeightAction({required this.height});
}

class SetWeightAction extends RegistryActions {
  final int weight;

  SetWeightAction({required this.weight});
}

class SaveProfileAction extends RegistryActions {
  final Function onFinish;

  SaveProfileAction({required this.onFinish});
}
