import 'package:firebase_auth/firebase_auth.dart';
import 'package:terapiasdaluna/domain/interactor/user/do_login_interactor.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';

class DoLoginInteractorImpl extends DoLoginInteractor {
  final UserRepository userRepository;

  DoLoginInteractorImpl({required this.userRepository});

  @override
  Future<UserCredential> execute(String email, String password) async => await userRepository.doLogin(email, password);

}