import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecblog/di/di.dart';

class AuthManager {
  static final SharedPreferences _sharedPreferences =
      locator.get<SharedPreferences>();
  static final ValueNotifier valueNotifier = ValueNotifier(null);

  static void saveId(String id) async {
    _sharedPreferences.setString('user_id', id);
  }

  static String readUserId() {
    return _sharedPreferences.getString("user_id") ?? "";
  }

  static void deleteUserId() {
    _sharedPreferences.remove('user_id');
  }

  static void saveToken(String token) async {
    await _sharedPreferences.setString("access_token", token);
    valueNotifier.value = token;
  }

  static String readToken() {
    return _sharedPreferences.getString("access_token") ?? "";
  }

  static void deleteToken() {
    _sharedPreferences.remove('access_token');
  }
}
