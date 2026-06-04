// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Smetti di Fumare';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get changeGradientTitle => 'Cambia sfumatura';

  @override
  String get languageTitle => 'Lingua';

  @override
  String get selectLanguageHint => 'Seleziona lingua';

  @override
  String get savingsSectionTitle => 'Risparmio';

  @override
  String get savingsTileTitle => 'Costo pacchetto e consumo medio';

  @override
  String get savingsTileSubtitle =>
      'Modifica i dati per calcolare il risparmio';

  @override
  String get homeIntroPart1 => 'Imposta la frequenza\ndelle notifiche per ';

  @override
  String get homeIntroSmettere => 'SMETTERE';

  @override
  String get homeIntroPart3 => ' di fumare';

  @override
  String get selectFrequencyHint => 'Seleziona frequenza';

  @override
  String get selectQueueHint => 'Seleziona quantità coda';

  @override
  String get frequency15 => 'Ogni 15 minuti';

  @override
  String get frequency30 => 'Ogni 30 minuti';

  @override
  String get frequency45 => 'Ogni 45 minuti';

  @override
  String get frequency1h => 'Ogni 1 ora';

  @override
  String get frequency2h => 'Ogni 2 ore';

  @override
  String get queue1 => '1 notifica';

  @override
  String get queue10 => '10 notifiche in coda';

  @override
  String get queue20 => '20 notifiche in coda';

  @override
  String get savingsEstimatedTitle => 'Risparmio stimato';

  @override
  String get days30 => '30 giorni';

  @override
  String get days60 => '60 giorni';

  @override
  String get days90 => '90 giorni';

  @override
  String get months6 => '6 mesi';

  @override
  String get year1 => '1 anno';

  @override
  String get resetNotificationTitle => 'Reimposta notifica';

  @override
  String get resetFrequencyTitle => 'Reimposta frequenza';

  @override
  String get resetFrequency => 'Reimposta la frequenza';

  @override
  String get savingsPageTitle => 'Il tuo risparmio';

  @override
  String get savingsIntro =>
      'Inserisci il costo medio del pacchetto e il consumo medio.';

  @override
  String get packPriceLabel => 'Costo medio del pacchetto';

  @override
  String get averageConsumptionLabel => 'Consumo medio pacchetto/sigarette';

  @override
  String get averageConsumptionSubtitle =>
      'Considerando un pacchetto da 20 sigarette,\n1 sigaretta = 0.05 pacchetto\n1.00 = 1 pacchetto';

  @override
  String get consumptionReferenceLabel => 'La quantità media si riferisce a';

  @override
  String get invalidNumberError => 'Inserisci un numero valido maggiore di 0';

  @override
  String get saveAndContinue => 'Salva e continua';

  @override
  String get consumptionOption1Day => 'Un giorno';

  @override
  String get consumptionOption2Days => 'Due giorni';

  @override
  String get consumptionOption3Days => 'Tre giorni';

  @override
  String get consumptionOption4Days => 'Quattro giorni';

  @override
  String get consumptionOption5Days => 'Cinque giorni';

  @override
  String get consumptionOption1Week => 'Una settimana';

  @override
  String get gradientRed => 'Rosso';

  @override
  String get gradientBlue => 'Blu';

  @override
  String get gradientGreen => 'Verde';

  @override
  String get gradientPurple => 'Viola';

  @override
  String get gradientOrange => 'Arancione';

  @override
  String get gradientGray => 'Grigio';

  @override
  String get optimizationSectionTitle => 'Ottimizza applicazione';

  @override
  String get exactAlarmSubtitle =>
      'Per un funzionamento più affidabile dell\'app, attiva la gestione degli allarmi esatti.';

  @override
  String get exactAlarmError =>
      'Impossibile aprire la schermata degli allarmi esatti su questo dispositivo.';

  @override
  String get batteryOptimizationError =>
      'Impossibile aprire la schermata delle informazioni su questo dispositivo.';

  @override
  String get batteryOptimizationSubtitle =>
      'Considera anche di togliere l\'ottimizzazione della batteria.';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get termsAndConditionsTitle => 'Termini e condizioni';
}
