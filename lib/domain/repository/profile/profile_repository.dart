import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';

abstract class ProfileRepository {
  Future<bool> uploadProfile(ProfileModel profileModel);
  Future<ProfileModel> getProfile(String userId);
  Future<void> saveTermsAndConditions(String acceptanceString, String email);
}