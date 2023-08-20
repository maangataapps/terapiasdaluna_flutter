import 'package:firebase_auth/firebase_auth.dart';
import 'package:terapiasdaluna/domain/repository/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth auth;
  UserRepositoryImpl({required this.auth});

  @override
  Future<User?> createUser(String name, String email, String password,) async {
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;

      try {
        final signInResult = await auth.signInWithEmailAndPassword(email: email, password: password);
        return signInResult.user;
      } catch (signInError) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> doLogin(String email, String password) async {
    try {
      final signInResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      return signInResult;
    } catch (signInError) {
      rethrow;
    }
  }

  @override
  Future<void> doLogOut() async {
    try{
      await auth.signOut();
      return;
    } catch (logOutError) {
      rethrow;
    }
  }

  @override
  Future<void> resetForgottenPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }

}