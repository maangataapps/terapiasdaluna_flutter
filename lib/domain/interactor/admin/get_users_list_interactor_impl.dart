import 'package:terapiasdaluna/domain/interactor/admin/get_users_list_interactor.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/domain/repository/admin/admin_repository.dart';

class GetUsersListInteractorImpl extends GetUsersListInteractor {
  final AdminRepository adminRepository;

  GetUsersListInteractorImpl({required this.adminRepository});

  @override
  Future<List<ProfileModel>> execute() async => await adminRepository.getUsersList();

}