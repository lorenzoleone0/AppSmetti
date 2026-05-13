import 'package:flutter/material.dart';
import 'dart:ui';
import 'app_storage.dart';

class AppLocaleController {
  static const List<String> _supportate = [
    'it',
    'en',
    'es',
    'fr',
    'de',
    'ru',
    'zh',
    'ko',
  ];

  static String _normalizza(String code) {
    return _supportate.contains(code) ? code : 'en';
  }

  static final ValueNotifier<Locale> locale =
      ValueNotifier<Locale>(Locale(_normalizza(PlatformDispatcher.instance.locale.languageCode)));

  static Future<void> loadSavedLocale() async {
    final saved = await AppStorage.loadLanguage();

    if (saved == null || saved.isEmpty) {
      final sistema = _normalizza(PlatformDispatcher.instance.locale.languageCode);
      locale.value = Locale(sistema);
      await AppStorage.saveLanguage(sistema);
      return;
    }

    final normalizzata = _normalizza(saved);
    locale.value = Locale(normalizzata);

    if (normalizzata != saved) {
      await AppStorage.saveLanguage(normalizzata);
    }
  }

  static Future<void> setLanguage(String languageCode) async {
    final normalizzata = _normalizza(languageCode);
    locale.value = Locale(normalizzata);
    await AppStorage.saveLanguage(normalizzata);
  }
}