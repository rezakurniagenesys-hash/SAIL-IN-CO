import 'package:flutter/material.dart';
import '../data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  // final _repo = UserRepository();

  UserModel? user;
  bool loading = false;

  // Future<void> fetchProfile() async {
  //   loading = true;
  //   notifyListeners();
  //   try {
  //     user = await _repo.getProfile();
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //   } finally {
  //     loading = false;
  //     notifyListeners();
  //   }
  // }
}
