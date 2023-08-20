import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

class AdminActions {
  AdminActions();
}

class InitialiseStateAction extends AdminActions {
  InitialiseStateAction();
}

class SelectUserAction extends AdminActions {
  final ProfileModel user;
  final Function onFinish;

  SelectUserAction({required this.user, required this.onFinish});
}