
abstract class PreferencesRepository {
  Future<void> setUserId(String userId);
  String getUserId(bool? forceAdminUserId);
  Future<void> setRequestingUserId(String requestUserId);
  String getRequestingUserId();
  Future<void> setEmail(String email);
  String getEmail();
  Future<void> setIdToken(String idToken);
  String getIdToken();
  Future<void> setUsername(String username);
  String getUsername();
  Future<void> setUserAdmin(bool isUserAdmin);
  bool getUserAdmin();
  Future<void> saveCredentials(String username, String userId, String email, String idToken, bool isUserAdmin);
  Future<void> clearCredentials();
}