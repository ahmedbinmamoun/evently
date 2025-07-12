import 'package:flutter/material.dart';
import 'package:event/utils/language_storage.dart'; // update path

class AppLanguageProvider with ChangeNotifier {
  String _appLanguage = 'en';

  String get appLanguage => _appLanguage;

  Locale get locale => Locale(_appLanguage);

  Future<void> loadLocale() async {
    _appLanguage = await LanguageStorage.loadLanguage();
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    if (_appLanguage == langCode) return;

    _appLanguage = langCode;
    LanguageStorage.saveLanguage(langCode);
    notifyListeners();
  }

  bool isEnglish() => _appLanguage == 'en';
}