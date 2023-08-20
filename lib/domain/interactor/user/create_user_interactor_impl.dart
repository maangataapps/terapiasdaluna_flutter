import 'package:firebase_auth/firebase_auth.dart';
import 'package:terapiasdaluna/domain/interactor/user/create_user_interactor.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';

class CreateUserInteractorImpl extends CreateUserInteractor {
  final UserRepository userRepository;
  final PreferencesRepository preferences;

  CreateUserInteractorImpl({required this.userRepository, required this.preferences,});

  @override
  Future<User?> execute(String name, String email, String password) async => await userRepository.createUser(name, email, password);

}