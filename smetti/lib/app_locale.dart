import 'package:flutter/material.dart';
import 'app_storage.dart';
import 'dart:ui';

class AppLocaleController {
  // 1. Inizializza con la lingua del sistema invece che 'en'
  static final ValueNotifier<Locale> locale =
      ValueNotifier<Locale>(Locale(PlatformDispatcher.instance.locale.languageCode));

  static Future<void> loadSavedLocale() async {
    final saved = await AppStorage.loadLanguage();
    
    // 2. Se non c'è nulla di salvato, NON forzare 'en'
    if (saved == null || saved.isEmpty) {
      // Prendi la lingua del dispositivo
      String sistema = PlatformDispatcher.instance.locale.languageCode;
      
      // Opzionale: se il telefono è in una lingua che non hai (es. Tedesco), 
      // Flutter userà comunque l'inglese grazie ai 'supportedLocales' nel main.
      locale.value = Locale(sistema);
      return;
    }
    locale.value = Locale(saved);
  }

  static Future<void> setLanguage(String languageCode) async {
    locale.value = Locale(languageCode);
    await AppStorage.saveLanguage(languageCode);
  }
}
