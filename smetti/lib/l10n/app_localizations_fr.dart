// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Arrête de Fumer';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get changeGradientTitle => 'Changer le dégradé';

  @override
  String get languageTitle => 'Langue';

  @override
  String get selectLanguageHint => 'Sélectionne la langue';

  @override
  String get savingsSectionTitle => 'Économies';

  @override
  String get savingsTileTitle => 'Prix du paquet et consommation moyenne';

  @override
  String get savingsTileSubtitle =>
      'Modifie les données pour calculer tes économies';

  @override
  String get homeIntroPart1 => 'Définis la fréquence\ndes notifications pour ';

  @override
  String get homeIntroSmettere => 'ARRÊTER';

  @override
  String get homeIntroPart3 => ' de fumer';

  @override
  String get selectFrequencyHint => 'Sélectionne la fréquence';

  @override
  String get selectQueueHint =>
      'Sélectionne le nombre de notifications en file d\'attente';

  @override
  String get frequency15 => 'Toutes les 15 minutes';

  @override
  String get frequency30 => 'Toutes les 30 minutes';

  @override
  String get frequency45 => 'Toutes les 45 minutes';

  @override
  String get frequency1h => 'Toutes les 1 heure';

  @override
  String get frequency2h => 'Toutes les 2 heures';

  @override
  String get queue1 => '1 notification';

  @override
  String get queue10 => '10 notifications en file d\'attente';

  @override
  String get queue20 => '20 notifications en file d\'attente';

  @override
  String get savingsEstimatedTitle => 'Économie estimée';

  @override
  String get days30 => '30 jours';

  @override
  String get days60 => '60 jours';

  @override
  String get days90 => '90 jours';

  @override
  String get months6 => '6 mois';

  @override
  String get year1 => '1 an';

  @override
  String get resetNotificationTitle => 'Réinitialiser la notification';

  @override
  String get resetFrequencyTitle => 'Réinitialiser la fréquence';

  @override
  String get resetFrequency => 'Réinitialiser la fréquence';

  @override
  String get savingsPageTitle => 'Tes économies';

  @override
  String get savingsIntro =>
      'Saisis le prix moyen du paquet et la consommation moyenne.';

  @override
  String get packPriceLabel => 'Prix moyen du paquet';

  @override
  String get averageConsumptionLabel =>
      'Consommation moyenne paquet/cigarettes';

  @override
  String get averageConsumptionSubtitle =>
      'En considérant un paquet de 20 cigarettes,\n1 cigarette = 0,05 paquet\n1,00 = 1 paquet';

  @override
  String get consumptionReferenceLabel => 'La quantité moyenne se réfère à';

  @override
  String get invalidNumberError => 'Saisis un nombre valide supérieur à 0';

  @override
  String get saveAndContinue => 'Enregistrer et continuer';

  @override
  String get consumptionOption1Day => 'Un jour';

  @override
  String get consumptionOption2Days => 'Deux jours';

  @override
  String get consumptionOption3Days => 'Trois jours';

  @override
  String get consumptionOption4Days => 'Quatre jours';

  @override
  String get consumptionOption5Days => 'Cinq jours';

  @override
  String get consumptionOption1Week => 'Une semaine';

  @override
  String get gradientRed => 'Rouge';

  @override
  String get gradientBlue => 'Bleu';

  @override
  String get gradientGreen => 'Vert';

  @override
  String get gradientPurple => 'Violet';

  @override
  String get gradientOrange => 'Orange';

  @override
  String get gradientGray => 'Gris';

  @override
  String get optimizationSectionTitle => 'Optimiser l\'application';

  @override
  String get exactAlarmSubtitle =>
      'Pour un fonctionnement plus fiable de l\'application, active la gestion des alarmes exactes.';

  @override
  String get exactAlarmError =>
      'Impossible d\'ouvrir l\'écran des alarmes exactes sur cet appareil.';

  @override
  String get batteryOptimizationError =>
      'Impossible d\'ouvrir l\'écran d\'informations sur cet appareil.';

  @override
  String get batteryOptimizationSubtitle =>
      'Pense aussi à désactiver l\'optimisation de la batterie.';

  @override
  String get privacyPolicyTitle => 'Politique de confidentialité';

  @override
  String get termsAndConditionsTitle => 'Conditions d’utilisation';
}
