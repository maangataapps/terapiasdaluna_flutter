abstract class SaveUserCredentialsInteractor {
  Future<void> execute(String username, String userId, String email, String idToken, bool isUserAdmin);
}