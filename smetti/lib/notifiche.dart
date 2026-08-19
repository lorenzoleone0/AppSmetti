import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'widget/widget_notilingue.dart';

import 'app_storage.dart';

class ServizioNotifiche {
  ServizioNotifiche._();
  static final ServizioNotifiche instance = ServizioNotifiche._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _inizializzato = false;
  bool _promemoriaAttivo = false;
  Duration? _durataAttiva;
  int? _totaleNotifiche;
  String? _ultimaFrase;
  String? _linguaAttiva;

  static const String _payloadPromemoria = 'smetti_di_fumare';

  Future<void> init() async {
    if (_inizializzato) return;

    //const androidInit = AndroidInitializationSettings('ic_launcher');
    const androidInit = AndroidInitializationSettings('ic_notification');
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

    await _plugin.initialize(settings: initSettings);

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    _inizializzato = true;
  }

  Duration? durataDaFrequenza(String frequenza) {
    switch (frequenza) {
      case '15m':
      case 'Ogni 15 minuti':
        return const Duration(minutes: 15);
      case '30m':
      case 'Ogni 30 minuti':
        return const Duration(minutes: 30);
      case '45m':
      case 'Ogni 45 minuti':
        return const Duration(minutes: 45);
      case '1h':
      case 'Ogni 1 ora':
        return const Duration(hours: 1);
      case '2h':
      case 'Ogni 2 ore':
        return const Duration(hours: 2);
      default:
        return null;
    }
  }
//-----------------------------------
Future<bool> _puoSchedulareExactAlarm() async {
  final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (android == null) return true;

  final canSchedule = await android.canScheduleExactNotifications();
  return canSchedule ?? false;
}

Future<bool> _richiediExactAlarm() async {
  final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (android == null) return true;

  final granted = await android.requestExactAlarmsPermission();
  return granted ?? false;
}

Future<bool> _assicuratiPermessoExactAlarm() async {
  await init();

  final puo = await _puoSchedulareExactAlarm();
  if (puo) return true;

  final richiesto = await _richiediExactAlarm();
  return richiesto;
}
//-----------------------------------
Future<bool> resettaPromemoriaSeTerminato() async {
  await init();

  final attivo = await AppStorage.loadReminderActive();
  if (!attivo) return false;

  final finePromemoria = await AppStorage.loadReminderEndAt();
  final pending = await _plugin.pendingNotificationRequests();

  final adesso = DateTime.now();
  final scaduto = finePromemoria != null && adesso.isAfter(finePromemoria);

  if (pending.isNotEmpty && !scaduto) return false;

  _promemoriaAttivo = false;
  _durataAttiva = null;
  _totaleNotifiche = null;
  _ultimaFrase = null;
  _linguaAttiva = null;

  await AppStorage.clearReminderPreferences();
  await _plugin.cancelAll();
  return true;
}

  String fraseCasuale() {
    final frasi = frasiPerLingua(_linguaAttiva);
    final disponibili = frasi.where((frase) => frase != _ultimaFrase).toList();

    final scelta = disponibili.isNotEmpty
        ? disponibili[Random().nextInt(disponibili.length)]
        : frasi[Random().nextInt(frasi.length)];

    _ultimaFrase = scelta;
    return scelta;
  }

  Future<void> _caricaLinguaAttiva() async {
    _linguaAttiva = await AppStorage.loadLanguage();
    _linguaAttiva ??=
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }

  Future<void> programmaPromemoria(String frequenza) async {

  final durata = durataDaFrequenza(frequenza);

  if (durata == null) {
    
    return;
  }

  final totaleNotifiche = await AppStorage.loadNotificationQueue();

  if (totaleNotifiche == null || totaleNotifiche <= 0) {
    
    return;
  }

  await init();
  await _caricaLinguaAttiva();
//-----------------------------------
final permessoOk = await _assicuratiPermessoExactAlarm();
if (!permessoOk) {
  return;
}
//-----------------------------------
  _promemoriaAttivo = true;
  _durataAttiva = durata;
  _totaleNotifiche = totaleNotifiche;
  _ultimaFrase = null;

  final finePromemoria = DateTime.now().add(durata * totaleNotifiche);

  await AppStorage.saveReminderEndAt(finePromemoria);

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

    final totaleNotifiche = await AppStorage.loadNotificationQueue();

    if (totaleNotifiche == null || totaleNotifiche <= 0) return;

    await _caricaLinguaAttiva();

    _promemoriaAttivo = true;
    _durataAttiva = durata;
    _totaleNotifiche = totaleNotifiche;

    final pending = await _plugin.pendingNotificationRequests();
    
//-------------------------------
final permessoOk = await _assicuratiPermessoExactAlarm();
if (!permessoOk) return;
//-------------------------------
    if (pending.isEmpty) {
      
      await _programmaSerieNotifiche();
    }
  }

  Future<void> aggiornaNotificheDopoCambioLingua() async {
    final attivo = await AppStorage.loadReminderActive();
    await _caricaLinguaAttiva();

    if (!attivo) return;

    final frequenza = await AppStorage.loadFrequency();
    final durata = frequenza != null ? durataDaFrequenza(frequenza) : null;
    final totaleNotifiche = await AppStorage.loadNotificationQueue();

    if (durata == null || totaleNotifiche == null || totaleNotifiche <= 0) {
      return;
    }

    await init();

    _promemoriaAttivo = true;
    _durataAttiva = durata;
    _totaleNotifiche = totaleNotifiche;
    _ultimaFrase = null;

    await _plugin.cancelAll();
    await _programmaSerieNotifiche();
  }


  Future<void> _programmaSerieNotifiche() async {

    if (!_promemoriaAttivo ||
        _durataAttiva == null ||
        _totaleNotifiche == null) {
         
      return;
    }

    final oraInizio = tz.TZDateTime.now(tz.local);

    for (int i = 1; i <= _totaleNotifiche!; i++) {
      final scheduledDate = oraInizio.add(_durataAttiva! * i);

      final isUltima = i == _totaleNotifiche!;
    final isSingola = _totaleNotifiche == 1;

     final body = isSingola
        ? fraseCasuale()
        : isUltima
            ? fraseReimposta(_linguaAttiva)
            : fraseCasuale();

    final title = isSingola
            ? titoloReimpostaNotifica(_linguaAttiva)
            : isUltima
                ? titoloReimpostaFrequenza(_linguaAttiva)
                : null;
          
      await _plugin.zonedSchedule(
        id: i,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'smetti_di_fumare_channel',
            'Promemoria Smetti di Fumare',
            channelDescription: 'Notifiche motivazionali personalizzate',
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: DarwinNotificationDetails(),
          macOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: _payloadPromemoria,
      );
    }
    
  }

  Future<void> cancellaPromemoria() async {


    _promemoriaAttivo = false;
    _durataAttiva = null;
    _totaleNotifiche = null;
    _ultimaFrase = null;

    await AppStorage.saveReminderActive(false);
    await _plugin.cancelAll();
    
  }
}