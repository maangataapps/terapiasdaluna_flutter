import 'package:terapiasdaluna/domain/interactor/user/get_userid_interactor.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';

class GetUserIdInteractorImpl extends GetUserIdInteractor {
  final PreferencesRepository preferencesRepository;

  GetUserIdInteractorImpl({required this.preferencesRepository});

  @override
  String execute({bool? forceAdminUserId}) => preferencesRepository.getUserId(forceAdminUserId);

}