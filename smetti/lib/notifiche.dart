import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'app_storage.dart';

class ServizioNotifiche {
  ServizioNotifiche._();
  static final ServizioNotifiche instance = ServizioNotifiche._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _inizializzato = false;
  bool _promemoriaAttivo = false;
  Duration? _durataAttiva;
  String? _ultimaFrase;

  static const int _totaleNotifiche = 50;
  static const String _payloadPromemoria = 'smetti_di_fumare';

  final List<String> frasi = const [
    'Smetti ora.',
    'Ogni sigaretta in meno conta.',
    'Respira, non fumare.',
    'Stai facendo una scelta migliore.',
    'Il tuo obiettivo è più forte dell’abitudine.',
  ];

  Future<void> init() async {
    if (_inizializzato) return;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
      macOS: darwinInit,
    );

    await _plugin.initialize(
      settings: initSettings,
    );

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    _inizializzato = true;
  }

  Duration? durataDaFrequenza(String frequenza) {
    switch (frequenza) {
      case 'Ogni 15 minuti':
        return const Duration(minutes: 15);
      case 'Ogni 30 minuti':
        return const Duration(minutes: 30);
      case 'Ogni 45 minuti':
        return const Duration(minutes: 45);
      case 'Ogni 1 ora':
        return const Duration(hours: 1);
      case 'Ogni 2 ore':
        return const Duration(hours: 2);
      case 'Ogni 4 ore':
        return const Duration(hours: 4);
      case 'Ogni 8 ore':
        return const Duration(hours: 8);
      default:
        return null;
    }
  }

  String fraseCasuale() {
    final disponibili = frasi.where((frase) => frase != _ultimaFrase).toList();

    final scelta = disponibili.isNotEmpty
        ? disponibili[Random().nextInt(disponibili.length)]
        : frasi[Random().nextInt(frasi.length)];

    _ultimaFrase = scelta;
    return scelta;
  }

  NotificationDetails _details() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'smetti_di_fumare_channel',
        'Promemoria Smetti di Fumare',
        channelDescription: 'Notifiche motivazionali personalizzate',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );
  }

  Future<void> programmaPromemoria(String frequenza) async {
    final durata = durataDaFrequenza(frequenza);
    if (durata == null) return;

    await init();

    _promemoriaAttivo = true;
    _durataAttiva = durata;
    _ultimaFrase = null;

    await AppStorage.saveReminderActive(true);

    await _plugin.cancelAll();
    await _programmaSerieNotifiche();
  }

  Future<void> sincronizzaPromemoriaAllAvvio() async {
    await init();

    final attivo = await AppStorage.loadReminderActive();
    if (!attivo) return;

    final frequenza = await AppStorage.loadFrequency();
    final durata = frequenza != null ? durataDaFrequenza(frequenza) : null;
    if (durata == null) return;

    _promemoriaAttivo = true;
    _durataAttiva = durata;

    final pending = await _plugin.pendingNotificationRequests();

    if (pending.isEmpty) {
      await _programmaSerieNotifiche();
    }
  }

  Future<void> _programmaSerieNotifiche() async {
    if (!_promemoriaAttivo || _durataAttiva == null) return;

    final oraInizio = tz.TZDateTime.now(tz.local);

    for (int i = 1; i <= _totaleNotifiche; i++) {
      final scheduledDate = oraInizio.add(_durataAttiva! * i);

      final body = i == _totaleNotifiche
          ? 'Reimposta la frequenza'
          : fraseCasuale();

      await _plugin.zonedSchedule(
        id: i,
        title: 'Smetti di Fumare',
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails: _details(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: _payloadPromemoria,
      );
    }
  }

  Future<void> cancellaPromemoria() async {
    _promemoriaAttivo = false;
    _durataAttiva = null;
    _ultimaFrase = null;

    await AppStorage.saveReminderActive(false);
    await _plugin.cancelAll();
  }
}

/* package com.example.smetti

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity()  */ 