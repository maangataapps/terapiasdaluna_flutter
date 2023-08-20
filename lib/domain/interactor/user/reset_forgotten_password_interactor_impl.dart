import 'package:terapiasdaluna/domain/interactor/user/reset_forgotten_password_interactor.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';

class ResetForgottenPasswordInteractorImpl extends ResetForgottenPasswordInteractor {
  final UserRepository userRepository;

  ResetForgottenPasswordInteractorImpl({required this.userRepository});

  @override
  Future<void> execute(String email) async => await userRepository.resetForgottenPassword(email);

}