import 'dart:convert';

import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _token = "TOKEN";
  static const _refresh = "REFRESH_TOKEN";
  static const _userInfo = "USER_INFO";

  static Future<void> saveToken(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token, token);
    await prefs.setString(_refresh, refreshToken);
  }

  static Future<String?> getToken() async {
    return (await SharedPreferences.getInstance()).getString(_token);
  }

  static Future<String?> getRefreshToken() async {
    return (await SharedPreferences.getInstance()).getString(_refresh);
  }

  static Future<void> saveUserInfo(String userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userInfo, userInfo);
  }

  static Future<UserInfo?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_userInfo);

    if (data == null || data.isEmpty) return null;

    try {
      return UserInfo.fromJson(jsonDecode(data));
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_token);
    await prefs.remove(_refresh);
    return true;
  }
}
