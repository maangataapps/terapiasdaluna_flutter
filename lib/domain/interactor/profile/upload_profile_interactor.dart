import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

abstract class UploadProfileInteractor {
  Future<bool> execute(ProfileModel profileModel);
}