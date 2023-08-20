import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User?> createUser(String name, String email, String password);
  Future<UserCredential> doLogin(String email, String password);
  Future<void> doLogOut();
  Future<void> resetForgottenPassword(String email);
}