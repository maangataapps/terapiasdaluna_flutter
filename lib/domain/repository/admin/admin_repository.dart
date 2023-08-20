import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

abstract class AdminRepository {
  Future<List<ProfileModel>> getUsersList();
  Future<void> saveRequestUserId(String requestUserId);
}