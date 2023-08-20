import 'package:terapiasdaluna/domain/interactor/profile/get_user_data_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/domain/repository/profile/profile_repository.dart';

class GetUserDataInteractorImpl extends GetUserDataInteractor {
  final ProfileRepository profileRepository;

  GetUserDataInteractorImpl({required this.profileRepository});

  @override
  Future<ProfileModel> execute(String userId) async => profileRepository.getProfile(userId);

}