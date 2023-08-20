import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';
import 'package:terapiasdaluna/domain/repository/profile/profile_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/profile_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class ProfileRepositoryImpl extends ProfileRepository {
  final FirebaseDatabase firebaseDatabase;
  final PreferencesRepository preferencesRepository;

  ProfileRepositoryImpl({
    required this.firebaseDatabase,
    required this.preferencesRepository,
  });

  @override
  Future<bool> uploadProfile(ProfileModel profileModel) async {
    final databaseReference = firebaseDatabase.ref('${constants.users}/${preferencesRepository.getUserId(false)}');
    try {
      databaseReference.set(
        profileModel.toJson(),
      );
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ProfileModel> getProfile(String userId) async {
    var ref = firebaseDatabase.ref('${constants.users}/$userId');
    final query = await ref.get().then((value) => value);
    final profileModel = ProfileHelper().createProfileModel(query);
    return profileModel;
  }

  @override
  Future<void> saveTermsAndConditions(String acceptanceString, String email) async {
    final userId = preferencesRepository.getUserId(false);
    final databaseReference = firebaseDatabase.ref('${constants.termsAndConditions}/$userId');
    try {
      databaseReference.set(
        {'acceptance' : acceptanceString},
      );
      return;
    } catch (error) {
      rethrow;
    }
  }

}