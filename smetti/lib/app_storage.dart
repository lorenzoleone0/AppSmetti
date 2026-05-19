import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _keyFrequency = 'pref_frequency';
  static const String _keyNotificationQueue = 'pref_notification_queue';
  static const String _keyGradientColor = 'pref_gradient_color';

  static const String _keyPackPrice = 'pref_pack_price';
  static const String _keyAverageAmount = 'pref_average_amount';
  static const String _keyConsumptionDays = 'pref_consumption_days';
  static const String _keyOnboardingCompleted = 'pref_onboarding_completed';
  static const String _keyReminderActive = 'pref_reminder_active';
  static const String _keyLanguage = 'pref_language';
  static const String _keyReminderEndAt = 'pref_reminder_end_at';
  static const String _keySavingsEggIndex = 'savings_egg_index';

  static Future<void> saveReminderEndAt(DateTime value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_keyReminderEndAt, value.toIso8601String());
}

 static Future<void> saveSavingsEggIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySavingsEggIndex, index);
  }

  static Future<int> loadSavingsEggIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keySavingsEggIndex) ?? 0;
  }

static Future<DateTime?> loadReminderEndAt() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(_keyReminderEndAt);
  return value == null ? null : DateTime.tryParse(value);
}

static Future<void> clearReminderPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_keyFrequency);
  await prefs.remove(_keyNotificationQueue);
  await prefs.remove(_keyReminderEndAt);
  await prefs.setBool(_keyReminderActive, false);
}

  static Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, value);
  }


  static Future<String?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  static Future<void> saveReminderActive(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyReminderActive, value);
  }

  static Future<bool> loadReminderActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyReminderActive) ?? false;
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, true);
  }

  static Future<void> saveFrequency(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFrequency, value);
  }

  static Future<String?> loadFrequency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFrequency);
  }

  static Future<void> saveNotificationQueue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyNotificationQueue, value);
  }

  static Future<int?> loadNotificationQueue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyNotificationQueue);
  }

  static Future<void> saveGradientColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGradientColor, color.value);
  }

  static Future<Color?> loadGradientColor() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_keyGradientColor);
    return value == null ? null : Color(value);
  }

  static Future<void> saveSavingsConfig({
    required double packPrice,
    required double averageAmount,
    required int consumptionDays,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyPackPrice, packPrice);
    await prefs.setDouble(_keyAverageAmount, averageAmount);
    await prefs.setInt(_keyConsumptionDays, consumptionDays);
  }

  static Future<double?> loadPackPrice() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyPackPrice);
  }

  static Future<double?> loadAverageAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyAverageAmount);
  }

  static Future<int?> loadConsumptionDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyConsumptionDays);
  }
}