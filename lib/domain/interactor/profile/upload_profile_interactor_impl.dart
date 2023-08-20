import 'package:terapiasdaluna/domain/interactor/profile/upload_profile_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/domain/repository/profile/profile_repository.dart';

class UploadProfileInteractorImpl extends UploadProfileInteractor {
  final ProfileRepository profileRepository;

  UploadProfileInteractorImpl({required this.profileRepository});

  @override
  Future<bool> execute(ProfileModel profileModel) async => profileRepository.uploadProfile(profileModel);

}