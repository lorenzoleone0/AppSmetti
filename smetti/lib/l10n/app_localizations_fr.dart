// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Quit Smoking';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get changeGradientTitle => 'Change gradient';

  @override
  String get languageTitle => 'Language';

  @override
  String get selectLanguageHint => 'Select language';

  @override
  String get savingsSectionTitle => 'Savings';

  @override
  String get savingsTileTitle => 'Pack cost and average consumption';

  @override
  String get savingsTileSubtitle => 'Edit the data to calculate savings';

  @override
  String get homeIntroPart1 => 'Set the notification frequency, to ';

  @override
  String get homeIntroSmettere => 'QUIT';

  @override
  String get homeIntroPart3 => ' smoking';

  @override
  String get selectFrequencyHint => 'Select frequency';

  @override
  String get selectQueueHint => 'Select queue size';

  @override
  String get frequency15 => 'Every 15 minutes';

  @override
  String get frequency30 => 'Every 30 minutes';

  @override
  String get frequency45 => 'Every 45 minutes';

  @override
  String get frequency1h => 'Every 1 hour';

  @override
  String get frequency2h => 'Every 2 hours';

  @override
  String get queue1 => '1 notification';

  @override
  String get queue10 => '10 notifications in queue';

  @override
  String get queue20 => '20 notifications in queue';

  @override
  String get queue30 => '30 notifications in queue';

  @override
  String get savingsEstimatedTitle => 'Estimated savings';

  @override
  String get days30 => '30 days';

  @override
  String get days60 => '60 days';

  @override
  String get days90 => '90 days';

  @override
  String get months6 => '6 months';

  @override
  String get year1 => '1 year';

  @override
  String get resetNotificationTitle => 'Reset notification';

  @override
  String get resetFrequencyTitle => 'Reset frequency';

  @override
  String get resetFrequency => 'Reset the frequency';

  @override
  String get savingsPageTitle => 'Your savings';

  @override
  String get savingsIntro =>
      'Enter the average pack price and your average consumption.';

  @override
  String get packPriceLabel => 'Average pack price';

  @override
  String get averageConsumptionLabel => 'Average pack/cigarette consumption';

  @override
  String get averageConsumptionSubtitle =>
      'Considering a pack of 20 cigarettes,\n1 cigarette = 0.05 pack\n1.00 = 1 pack';

  @override
  String get consumptionReferenceLabel => 'The average quantity refers to';

  @override
  String get invalidNumberError => 'Enter a valid number greater than 0';

  @override
  String get saveAndContinue => 'Save and continue';

  @override
  String get consumptionOption1Day => 'One day';

  @override
  String get consumptionOption2Days => 'Two days';

  @override
  String get consumptionOption3Days => 'Three days';

  @override
  String get consumptionOption4Days => 'Four days';

  @override
  String get consumptionOption5Days => 'Five days';

  @override
  String get consumptionOption1Week => 'One week';

  @override
  String get gradientRed => 'Red';

  @override
  String get gradientBlue => 'Blue';

  @override
  String get gradientGreen => 'Green';

  @override
  String get gradientPurple => 'Purple';

  @override
  String get gradientOrange => 'Orange';

  @override
  String get gradientGray => 'Gray';

  @override
  String get optimizationSectionTitle => 'Optimize app';

  @override
  String get exactAlarmSubtitle =>
      'For more reliable app behavior, enable exact alarm handling.';

  @override
  String get exactAlarmError =>
      'Unable to open the exact alarm settings screen on this device.';

  @override
  String get batteryOptimizationError =>
      'Unable to open the About screen on this device.';

  @override
  String get batteryOptimizationSubtitle =>
      'Also consider turning off battery optimization.';
}
