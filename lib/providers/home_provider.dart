import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/services/auth_service.dart';

class HomeProvider extends ChangeNotifier {
  UserInfo? userInfo;
  bool loading = false;

  void init() {
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    try {
      userInfo = await AuthService.getUserInfo();
    } catch (e) {
      debugPrint("Error loading user info: $e");
    } finally {
      notifyListeners();
    }
  }
}
