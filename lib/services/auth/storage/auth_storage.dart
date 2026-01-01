import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

class AuthStorage {
  final FlutterSecureStorage _storage;

  static const _authDataKey = 'vk_auth_data';

  AuthStorage(this._storage);

  Future<void> saveAuthData(AuthData authData) async {
    final json = jsonEncode({
      'token': authData.token,
      'idToken': authData.idToken,
      'userID': authData.userID,
      'expireTime': authData.expireTime,
      'scopes': authData.scopes.toList(),
      'user': {
        'firstName': authData.userData.firstName,
        'lastName': authData.userData.lastName,
        'phone': authData.userData.phone,
        'avatarUrl': authData.userData.avatarUrl,
        'email': authData.userData.email,
      },
    });

    await _storage.write(key: _authDataKey, value: json);
  }

  Future<bool> hasToken() async {
    return _storage.containsKey(key: _authDataKey);
  }

  Future<AuthData> restoreAuthData() async {
    final raw = await _storage.read(key: _authDataKey);
    if (raw == null) {
      throw StateError('No auth data stored');
    }

    final map = jsonDecode(raw) as Map<String, dynamic>;

    final user = User(
      map['user']['firstName'] as String,
      map['user']['lastName'] as String,
      map['user']['phone'] as String,
      map['user']['avatarUrl'] as String,
      map['user']['email'] as String,
    );

    return AuthData(
      map['token'] as String,
      map['idToken'] as String,
      map['userID'] as int,
      map['expireTime'] as int,
      user,
      Set<String>.from(map['scopes']),
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _authDataKey);
  }
}
