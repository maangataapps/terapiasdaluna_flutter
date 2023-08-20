import 'package:terapiasdaluna/domain/interactor/admin/save_request_user_id_interactor.dart';
import 'package:terapiasdaluna/domain/repository/admin/admin_repository.dart';
import 'package:terapiasdaluna/infrastructure/utils/string_constants.dart';

class SaveRequestUserIdInteractorImpl extends SaveRequestUserIdInteractor {
  final AdminRepository adminRepository;

  SaveRequestUserIdInteractorImpl({required this.adminRepository});

  @override
  Future<void> execute(String requestUserId) async => await adminRepository.saveRequestUserId(requestUserId);

}