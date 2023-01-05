import 'dart:ffi';

import 'package:charity/di/di.dart';
import 'package:charity/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final FlutterSecureStorage _secureStorage = locator.get();
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);

  static void saveToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);

    authChangeNotifire.value = token;
  }

  static Future<String?> readauth() async {
    final _token = await _secureStorage.read(key: 'access_token');
    authChangeNotifire.value = await _secureStorage.read(key: 'access_token');
    return _token;
  }

  static Future<void> logout() async {
    await _secureStorage.deleteAll();
    authChangeNotifire.value = null;
    MyApp.pageValuNotifire.value = 3;
  }

  static Future<bool> isLogin() async {
    String? _token = await readauth();
    if (_token == null || _token == '' || _token.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
