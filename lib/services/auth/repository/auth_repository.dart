import 'package:vkid_flutter_sdk/library_vkid.dart';

import '../storage/auth_storage.dart';

class AuthRepository {
  final AuthStorage _storage;

  AuthRepository(this._storage);

  Future<void> saveSession(AuthData authData) async {
    await _storage.saveAuthData(authData);
  }

  Future<bool> hasSession() async {
    return _storage.hasToken();
  }

  Future<AuthData> restoreSession() async {
    return _storage.restoreAuthData();
  }

  Future<void> clearSession() async {
    await _storage.clear();
  }
}
