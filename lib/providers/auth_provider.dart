// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/repositories/auth_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/ui/screens/dashboard/dashboard.dart';

class AuthProvider extends ChangeNotifier {
  final _repo = AuthRepository();

  bool loading = false;
  String? token;
  String? refreshToken;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool get isLoggedIn => token != null;
  bool get isLoading => loading;

  void setDebugLogin() {
    usernameController.text = "superadmin";
    passwordController.text = "123321";
  }

  Future<bool> login() async {
    loading = true;
    notifyListeners();

    try {
      final res = await _repo.login(usernameController.text, passwordController.text);

      token = res.data?.token ?? '';
      refreshToken = res.data?.refreshToken ?? '';

      await AuthService.saveToken(token!, refreshToken!);
      await AuthService.saveUserInfo(jsonEncode(res.data?.userInfo?.toJson() ?? {}));

      loading = false;
      clear();
      notifyListeners();
      return (res.result ?? false);
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  void actionLogin(BuildContext context) async {
    final success = await login();
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      // Login gagal
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal. Periksa kembali username dan kata sandi Anda.'), behavior: SnackBarBehavior.floating));
    }
  }

  Future<void> loadTokenFromStorage() async {
    token = await AuthService.getToken();
    refreshToken = await AuthService.getRefreshToken();
    notifyListeners();
  }

  Future<bool> checkTokenOnStart() async {
    final savedToken = await AuthService.getToken();
    final savedRefresh = await AuthService.getRefreshToken();

    if (savedToken == null || savedToken.isEmpty) {
      return false; // no token → go to login
    }

    try {
      // 1. VERIFY TOKEN
      final verifyRes = await _repo.verifyToken(savedToken);

      if (verifyRes == true) {
        token = savedToken;
        refreshToken = savedRefresh;
        return true; // token valid → go to home
      }
    } catch (_) {
      // verify failed → try refresh
    }

    // 2. REFRESH TOKEN
    try {
      final refreshRes = await _repo.refreshToken(savedToken, savedRefresh ?? '');

      final newToken = refreshRes.data?.token ?? '';
      final newRefresh = refreshRes.data?.refreshToken ?? '';

      token = newToken;
      refreshToken = newRefresh;

      await AuthService.saveToken(newToken, newRefresh);

      return true; // refresh berhasil → login otomatis
    } catch (e) {
      return false; // dua-duanya gagal → go login
    }
  }

  void clear() {
    usernameController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<void> logout() async {
    token = null;
    refreshToken = null;
    await AuthService.clear();
    notifyListeners();
  }
}
