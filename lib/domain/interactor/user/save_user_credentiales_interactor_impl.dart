import 'package:terapiasdaluna/domain/interactor/user/save_user_credentiales_interactor.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';

class SaveUserCredentialsInteractorImpl extends SaveUserCredentialsInteractor {
  final PreferencesRepository preferencesRepository;

  SaveUserCredentialsInteractorImpl({required this.preferencesRepository});

  @override
  Future<void> execute(String username, String userId, String email, String idToken, bool isUserAdmin) async => preferencesRepository.saveCredentials(username, userId, email, idToken, isUserAdmin);

}