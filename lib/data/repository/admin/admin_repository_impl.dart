import 'package:firebase_database/firebase_database.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/domain/repository/admin/admin_repository.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';
import 'package:terapiasdaluna/infrastructure/helpers/profile_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart' as constants;

class AdminRepositoryImpl extends AdminRepository {
  final FirebaseDatabase firebaseDatabase;
  final PreferencesRepository preferencesRepository;
  final _profileHelper = ProfileHelper();

  AdminRepositoryImpl({
    required this.firebaseDatabase,
    required this.preferencesRepository,
  });

  @override
  Future<List<ProfileModel>> getUsersList() async {
    final ref = firebaseDatabase.ref(constants.users);
    final query = await ref.get().then((value) => value);
    final usersList = query.children.map((user) => _profileHelper.createProfileModel(user)).toList();
    return usersList;
  }

  @override
  Future<void> saveRequestUserId(String requestUserId) async => preferencesRepository.setRequestingUserId(requestUserId);

}