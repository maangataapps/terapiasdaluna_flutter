import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

abstract class GetUserDataInteractor {
  Future<ProfileModel> execute(String userId);
}