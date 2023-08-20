import 'package:terapiasdaluna/domain/interactor/user/save_terms_and_conditions_interactor.dart';
import 'package:terapiasdaluna/domain/repository/profile/profile_repository.dart';

class SaveTermsAndConditionsInteractorImpl extends SaveTermsAndConditionsInteractor {
  final ProfileRepository profileRepository;

  SaveTermsAndConditionsInteractorImpl({required this.profileRepository});

  @override
  Future<void> execute(String acceptanceString, String email) async => await profileRepository.saveTermsAndConditions(acceptanceString, email);

}