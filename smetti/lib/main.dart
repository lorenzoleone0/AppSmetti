import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'l10n/app_localizations.dart';
import 'package:smetti/Pagina_Iniziale.dart';
import 'package:smetti/Pagina_Risparmio.dart';
import 'package:smetti/notifiche.dart';
import 'package:smetti/app_storage.dart';
import 'package:smetti/app_locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  try {
  final currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
} catch (e) {
  debugPrint('Timezone lookup failed: $e');
  tz.setLocalLocation(tz.getLocation('UTC'));
}
  await AppLocaleController.loadSavedLocale();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await ServizioNotifiche.instance.init();
  await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
  await ServizioNotifiche.instance.resettaPromemoriaSeTerminato();

  runApp(const MyApp());
  
  /* await ServizioNotifiche.instance.init();
  await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
  await ServizioNotifiche.instance.resettaPromemoriaSeTerminato(); */ 
 /*  await AppLocaleController.loadSavedLocale();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      await ServizioNotifiche.instance.init();
      await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
      await ServizioNotifiche.instance.resettaPromemoriaSeTerminato();
    } catch (e) {
      debugPrint('Errore inizializzazione notifiche: $e');
    }
  }); */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.locale,
      builder: (context, locale, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const AppEntryGate(),
        );
      },
    );
  }
}

class AppEntryGate extends StatefulWidget {
  const AppEntryGate({super.key});

  @override
  State<AppEntryGate> createState() => _AppEntryGateState();
}

class _AppEntryGateState extends State<AppEntryGate> {
  late final Future<bool> _futureCompleted;

  @override
  void initState() {
    super.initState();
    _futureCompleted = AppStorage.isOnboardingCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureCompleted,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final completed = snapshot.data ?? false;

        if (!completed) {
          return const PaginaRisparmio(fromFirstLaunch: true);
        }

        return const PaginaIniziale();
      },
    );
  }
}