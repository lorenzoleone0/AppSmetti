import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit Smoking'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @changeGradientTitle.
  ///
  /// In en, this message translates to:
  /// **'Change gradient'**
  String get changeGradientTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @selectLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguageHint;

  /// No description provided for @savingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savingsSectionTitle;

  /// No description provided for @savingsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Pack cost and average consumption'**
  String get savingsTileTitle;

  /// No description provided for @savingsTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Edit the data to calculate savings'**
  String get savingsTileSubtitle;

  /// No description provided for @homeIntroPart1.
  ///
  /// In en, this message translates to:
  /// **'Set the notification frequency to '**
  String get homeIntroPart1;

  /// No description provided for @homeIntroSmettere.
  ///
  /// In en, this message translates to:
  /// **'QUIT'**
  String get homeIntroSmettere;

  /// No description provided for @homeIntroPart3.
  ///
  /// In en, this message translates to:
  /// **' smoking'**
  String get homeIntroPart3;

  /// No description provided for @selectFrequencyHint.
  ///
  /// In en, this message translates to:
  /// **'Select frequency'**
  String get selectFrequencyHint;

  /// No description provided for @selectQueueHint.
  ///
  /// In en, this message translates to:
  /// **'Select queue size'**
  String get selectQueueHint;

  /// No description provided for @frequency15.
  ///
  /// In en, this message translates to:
  /// **'Every 15 minutes'**
  String get frequency15;

  /// No description provided for @frequency30.
  ///
  /// In en, this message translates to:
  /// **'Every 30 minutes'**
  String get frequency30;

  /// No description provided for @frequency45.
  ///
  /// In en, this message translates to:
  /// **'Every 45 minutes'**
  String get frequency45;

  /// No description provided for @frequency1h.
  ///
  /// In en, this message translates to:
  /// **'Every 1 hour'**
  String get frequency1h;

  /// No description provided for @frequency2h.
  ///
  /// In en, this message translates to:
  /// **'Every 2 hours'**
  String get frequency2h;

  /// No description provided for @queue1.
  ///
  /// In en, this message translates to:
  /// **'1 notification'**
  String get queue1;

  /// No description provided for @queue10.
  ///
  /// In en, this message translates to:
  /// **'10 notifications in queue'**
  String get queue10;

  /// No description provided for @queue20.
  ///
  /// In en, this message translates to:
  /// **'20 notifications in queue'**
  String get queue20;

  /// No description provided for @savingsEstimatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated savings'**
  String get savingsEstimatedTitle;

  /// No description provided for @days30.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get days30;

  /// No description provided for @days60.
  ///
  /// In en, this message translates to:
  /// **'60 days'**
  String get days60;

  /// No description provided for @days90.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get days90;

  /// No description provided for @months6.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get months6;

  /// No description provided for @year1.
  ///
  /// In en, this message translates to:
  /// **'1 year'**
  String get year1;

  /// No description provided for @resetNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset notification'**
  String get resetNotificationTitle;

  /// No description provided for @resetFrequencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset frequency'**
  String get resetFrequencyTitle;

  /// No description provided for @resetFrequency.
  ///
  /// In en, this message translates to:
  /// **'Reset the frequency'**
  String get resetFrequency;

  /// No description provided for @savingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Your savings'**
  String get savingsPageTitle;

  /// No description provided for @savingsIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter the average pack price and your average consumption.'**
  String get savingsIntro;

  /// No description provided for @packPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Average pack price'**
  String get packPriceLabel;

  /// No description provided for @averageConsumptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Average pack/cigarette consumption'**
  String get averageConsumptionLabel;

  /// No description provided for @averageConsumptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Considering a pack of 20 cigarettes,\n1 cigarette = 0.05 pack\n1.00 = 1 pack'**
  String get averageConsumptionSubtitle;

  /// No description provided for @consumptionReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'The average quantity refers to'**
  String get consumptionReferenceLabel;

  /// No description provided for @invalidNumberError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number greater than 0'**
  String get invalidNumberError;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save and continue'**
  String get saveAndContinue;

  /// No description provided for @consumptionOption1Day.
  ///
  /// In en, this message translates to:
  /// **'One day'**
  String get consumptionOption1Day;

  /// No description provided for @consumptionOption2Days.
  ///
  /// In en, this message translates to:
  /// **'Two days'**
  String get consumptionOption2Days;

  /// No description provided for @consumptionOption3Days.
  ///
  /// In en, this message translates to:
  /// **'Three days'**
  String get consumptionOption3Days;

  /// No description provided for @consumptionOption4Days.
  ///
  /// In en, this message translates to:
  /// **'Four days'**
  String get consumptionOption4Days;

  /// No description provided for @consumptionOption5Days.
  ///
  /// In en, this message translates to:
  /// **'Five days'**
  String get consumptionOption5Days;

  /// No description provided for @consumptionOption1Week.
  ///
  /// In en, this message translates to:
  /// **'One week'**
  String get consumptionOption1Week;

  /// No description provided for @gradientRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get gradientRed;

  /// No description provided for @gradientBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get gradientBlue;

  /// No description provided for @gradientGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get gradientGreen;

  /// No description provided for @gradientPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get gradientPurple;

  /// No description provided for @gradientOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get gradientOrange;

  /// No description provided for @gradientGray.
  ///
  /// In en, this message translates to:
  /// **'Gray'**
  String get gradientGray;

  /// No description provided for @optimizationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimize app'**
  String get optimizationSectionTitle;

  /// No description provided for @exactAlarmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For more reliable app behavior, enable exact alarm handling.'**
  String get exactAlarmSubtitle;

  /// No description provided for @exactAlarmError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the exact alarm settings screen on this device.'**
  String get exactAlarmError;

  /// No description provided for @batteryOptimizationError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the About screen on this device.'**
  String get batteryOptimizationError;

  /// No description provided for @batteryOptimizationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Also consider turning off battery optimization.'**
  String get batteryOptimizationSubtitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @termsAndConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditionsTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ko',
    'pt',
    'ru',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
