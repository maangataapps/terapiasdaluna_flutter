import 'package:terapiasdaluna/domain/repository/preferences/preferences.dart';
import 'package:terapiasdaluna/domain/repository/preferences/preferences_repository.dart';
import 'package:terapiasdaluna/infrastructure/utils/prefs_keys.dart';

class PreferencesRepositoryImpl extends PreferencesRepository {
  final Preferences prefs;

  PreferencesRepositoryImpl({required this.prefs});

  @override
  String getUserId(bool? forceAdminUserId) {
    if (getUserAdmin()) {
      if (forceAdminUserId != null && forceAdminUserId) {
        return prefs.getString(PrefsKeys.userId);
      } else {
        return getRequestingUserId();
      }
    } else {
      return prefs.getString(PrefsKeys.userId);
    }
  }

  @override
  Future<void> setUserId(String userId) async => await prefs.setString(PrefsKeys.userId, userId);

  @override
  String getEmail() => prefs.getString(PrefsKeys.email);

  @override
  String getIdToken() => prefs.getString(PrefsKeys.token);

  @override
  Future<void> setEmail(String email) async => await prefs.setString(PrefsKeys.email, email);

  @override
  Future<void> setIdToken(String idToken) async => await prefs.setString(PrefsKeys.token, idToken);

  @override
  String getUsername() => prefs.getString(PrefsKeys.username);

  @override
  Future<void> setUsername(String username) async => await prefs.setString(PrefsKeys.username, username);

  @override
  String getRequestingUserId() => prefs.getString(PrefsKeys.requestingUserId);

  @override
  Future<void> setRequestingUserId(String requestUserId) => prefs.setString(PrefsKeys.requestingUserId, requestUserId);

  @override
  bool getUserAdmin() => prefs.getBool(PrefsKeys.isUserAdmin);

  @override
  Future<void> setUserAdmin(bool isUserAdmin) async => prefs.setBool(PrefsKeys.isUserAdmin, isUserAdmin);


  @override
  Future<void> saveCredentials(String username, String userId, String email, String idToken, bool isUserAdmin) async {
    await setUsername(username);
    await setUserId(userId);
    await setEmail(email);
    await setIdToken(idToken);
    await setUserAdmin(isUserAdmin);
  }

  @override
  Future<void> clearCredentials() async => prefs.clearPreferences();

}