import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class ProfileHelper {
  ProfileModel createProfileModel(DataSnapshot snapshot) {
    return ProfileModel(
      userId: snapshot.child(constants.userId).value as String,
      name: snapshot.child(constants.name).value as String,
      userType: snapshot.child(constants.userType).value as int,
      birthDate: snapshot.child(constants.birthDate).value as int,
      height: snapshot.child(constants.height).value as int,
      weight: snapshot.child(constants.weight).value as int,
      sex: snapshot.child(constants.sex).value as int,
    );
  }
}