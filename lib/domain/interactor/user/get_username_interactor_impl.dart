import 'package:terapiasdaluna/domain/interactor/user/get_username_interactor.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';

class GetUsernameInteractorImpl extends GetUsernameInteractor {
  final PreferencesRepository preferencesRepository;

  GetUsernameInteractorImpl({required this.preferencesRepository});

  @override
  String execute() => preferencesRepository.getUsername();

}