import 'package:terapiasdaluna/domain/interactor/dashboard/perform_log_out_interactor.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';

class PerformLogOutInteractorImpl extends PerformLogOutInteractor {
  final UserRepository userRepository;

  PerformLogOutInteractorImpl({required this.userRepository});


  @override
  Future<void> execute() async => await userRepository.doLogOut();

}