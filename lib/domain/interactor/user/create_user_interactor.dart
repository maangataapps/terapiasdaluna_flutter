import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateUserInteractor {
  Future<User?> execute(String name, String email, String password);
}