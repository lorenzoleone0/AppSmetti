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
  int? _totaleNotifiche;
  String? _ultimaFrase;
  String? _linguaAttiva;

  static const String _payloadPromemoria = 'smetti_di_fumare';

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
      case '4h':
      case 'Ogni 4 ore':
        return const Duration(hours: 4);
      case '8h':
      case 'Ogni 8 ore':
        return const Duration(hours: 8);
      default:
        return null;
    }
  }

  List<String> _frasiPerLingua(String? code) {
    switch (code) {
      case 'it':
        return const [
          'Smetti ora.',
          'Ogni sigaretta in meno conta.',
          'Respira, non fumare.',
          'Stai facendo una scelta migliore.',
          'Il tuo obiettivo è più forte dell’abitudine.',
        ];
      case 'es':
        return const [
          'Deja de fumar ahora.',
          'Cada cigarrillo menos cuenta.',
          'Respira, no fumes.',
          'Estás tomando una mejor decisión.',
          'Tu objetivo es más fuerte que el hábito.',
        ];
      case 'fr':
        return const [
          'Arrête maintenant.',
          'Chaque cigarette en moins compte.',
          'Respire, ne fume pas.',
          'Tu fais un meilleur choix.',
          'Ton objectif est plus fort que l’habitude.',
        ];
      case 'de':
        return const [
          'Hör jetzt auf.',
          'Jede Zigarette weniger zählt.',
          'Atme, rauche nicht.',
          'Du triffst eine bessere Wahl.',
          'Dein Ziel ist stärker als die Gewohnheit.',
        ];
      case 'ru':
        return const [
          'Остановись сейчас.',
          'Каждая сигарета меньше имеет значение.',
          'Дыши, не кури.',
          'Ты делаешь лучший выбор.',
          'Твоя цель сильнее привычки.',
        ];
      case 'zh':
        return const [
          '现在就停止。',
          '少抽一支也很重要。',
          '呼吸，不要吸烟。',
          '你正在做出更好的选择。',
          '你的目标比习惯更强大。',
        ];
      case 'ko':
        return const [
          '지금 멈추세요.',
          '담배 한 개비라도 줄이면 의미가 있습니다.',
          '숨을 쉬고, 담배를 피우지 마세요.',
          '더 나은 선택을 하고 있습니다.',
          '목표가 습관보다 더 강합니다.',
        ];
      default:
        return const [
          'Stop now.',
          'Every cigarette less counts.',
          'Breathe, do not smoke.',
          'You are making a better choice.',
          'Your goal is stronger than the habit.',
        ];
    }
  }

  String _fraseReimposta(String? code) {
    switch (code) {
      case 'it':
        return 'Ripristina la frequenza';
      case 'es':
        return 'Reconfigura la frecuencia';
      case 'fr':
        return 'Réinitialise la fréquence';
      case 'de':
        return 'Frequenz neu einstellen';
      case 'ru':
        return 'Сбросьте частоту';
      case 'zh':
        return '重新设置频率';
      case 'ko':
        return '빈도를 다시 설정하세요';
      default:
        return 'Reset the frequency';
    }
  }

  String fraseCasuale() {
    final frasi = _frasiPerLingua(_linguaAttiva);
    final disponibili = frasi.where((frase) => frase != _ultimaFrase).toList();

    final scelta = disponibili.isNotEmpty
        ? disponibili[Random().nextInt(disponibili.length)]
        : frasi[Random().nextInt(frasi.length)];

    _ultimaFrase = scelta;
    return scelta;
  }

  Future<void> _caricaLinguaAttiva() async {
    _linguaAttiva = await AppStorage.loadLanguage();
  }

  Future<void> programmaPromemoria(String frequenza) async {
    final durata = durataDaFrequenza(frequenza);
    if (durata == null) return;

    final totaleNotifiche = await AppStorage.loadNotificationQueue();
    if (totaleNotifiche == null || totaleNotifiche <= 0) return;

    await init();
    await _caricaLinguaAttiva();

    _promemoriaAttivo = true;
    _durataAttiva = durata;
    _totaleNotifiche = totaleNotifiche;
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

    final totaleNotifiche = await AppStorage.loadNotificationQueue();
    if (totaleNotifiche == null || totaleNotifiche <= 0) return;

    await _caricaLinguaAttiva();

    _promemoriaAttivo = true;
    _durataAttiva = durata;
    _totaleNotifiche = totaleNotifiche;

    final pending = await _plugin.pendingNotificationRequests();

    if (pending.isEmpty) {
      await _programmaSerieNotifiche();
    }
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

      final body = i == _totaleNotifiche!
          ? _fraseReimposta(_linguaAttiva)
          : fraseCasuale();

      await _plugin.zonedSchedule(
        id: i,
        title: 'Smetti di Fumare',
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'smetti_di_fumare_channel',
            'Promemoria Smetti di Fumare',
            channelDescription: 'Notifiche motivazionali personalizzate',
            importance: Importance.max,
            priority: Priority.high,
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