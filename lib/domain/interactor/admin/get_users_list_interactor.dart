import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

abstract class GetUsersListInteractor {
  Future<List<ProfileModel>> execute();
}