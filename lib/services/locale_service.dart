import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const _key = 'locale_code';
  Locale _locale = const Locale('id'); // default bahasa Indonesia

  Locale get locale => _locale;

  bool get isEnglish => _locale.languageCode == 'en';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null && code.isNotEmpty) {
      _locale = Locale(code);
    }
    notifyListeners();
  }

  Future<void> setLocale(String code) async {
    _locale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
  }

  Future<void> switchLanguage(String code) async {
    await setLocale(code);
  }
}
