import 'package:terapiasdaluna/domain/interactor/user/clear_credentials_interactor.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';

class ClearCredentialsInteractorImpl extends ClearCredentialsInteractor {
  final PreferencesRepository preferencesRepository;

  ClearCredentialsInteractorImpl({required this.preferencesRepository});

  @override
  Future<void> execute() async => await preferencesRepository.clearCredentials();

}