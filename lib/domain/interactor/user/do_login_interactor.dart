import 'package:firebase_auth/firebase_auth.dart';

abstract class DoLoginInteractor {
  Future<UserCredential> execute(String email, String password);
}