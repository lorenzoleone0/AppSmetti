// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Бросить курить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get changeGradientTitle => 'Изменить градиент';

  @override
  String get languageTitle => 'Язык';

  @override
  String get selectLanguageHint => 'Выберите язык';

  @override
  String get savingsSectionTitle => 'Экономия';

  @override
  String get savingsTileTitle => 'Стоимость пачки и среднее потребление';

  @override
  String get savingsTileSubtitle =>
      'Измените данные, чтобы рассчитать экономию';

  @override
  String get homeIntroPart1 => 'Установите частоту\nуведомлений, чтобы ';

  @override
  String get homeIntroSmettere => 'БРОСИТЬ';

  @override
  String get homeIntroPart3 => ' курить';

  @override
  String get selectFrequencyHint => 'Выберите частоту';

  @override
  String get selectQueueHint => 'Выберите количество уведомлений в очереди';

  @override
  String get frequency15 => 'Каждые 15 минут';

  @override
  String get frequency30 => 'Каждые 30 минут';

  @override
  String get frequency45 => 'Каждые 45 минут';

  @override
  String get frequency1h => 'Каждый 1 час';

  @override
  String get frequency2h => 'Каждые 2 часа';

  @override
  String get queue1 => '1 уведомление';

  @override
  String get queue10 => '10 уведомлений в очереди';

  @override
  String get queue20 => '20 уведомлений в очереди';

  @override
  String get savingsEstimatedTitle => 'Оценка экономии';

  @override
  String get days30 => '30 дней';

  @override
  String get days60 => '60 дней';

  @override
  String get days90 => '90 дней';

  @override
  String get months6 => '6 месяцев';

  @override
  String get year1 => '1 год';

  @override
  String get resetNotificationTitle => 'Сбросить уведомление';

  @override
  String get resetFrequencyTitle => 'Сбросить частоту';

  @override
  String get resetFrequency => 'Сбросить частоту';

  @override
  String get savingsPageTitle => 'Твоя экономия';

  @override
  String get savingsIntro =>
      'Введите среднюю стоимость пачки и среднее потребление.';

  @override
  String get packPriceLabel => 'Средняя стоимость пачки';

  @override
  String get averageConsumptionLabel => 'Среднее потребление пачек/сигарет';

  @override
  String get averageConsumptionSubtitle =>
      'Если считать пачку из 20 сигарет,\n1 сигарета = 0,05 пачки\n1,00 = 1 пачка';

  @override
  String get consumptionReferenceLabel => 'Средний расход относится к';

  @override
  String get invalidNumberError => 'Введите корректное число больше 0';

  @override
  String get saveAndContinue => 'Сохранить и продолжить';

  @override
  String get consumptionOption1Day => 'Один день';

  @override
  String get consumptionOption2Days => 'Два дня';

  @override
  String get consumptionOption3Days => 'Три дня';

  @override
  String get consumptionOption4Days => 'Четыре дня';

  @override
  String get consumptionOption5Days => 'Пять дней';

  @override
  String get consumptionOption1Week => 'Одна неделя';

  @override
  String get gradientRed => 'Красный';

  @override
  String get gradientBlue => 'Синий';

  @override
  String get gradientGreen => 'Зелёный';

  @override
  String get gradientPurple => 'Фиолетовый';

  @override
  String get gradientOrange => 'Оранжевый';

  @override
  String get gradientGray => 'Серый';

  @override
  String get optimizationSectionTitle => 'Оптимизировать приложение';

  @override
  String get exactAlarmSubtitle =>
      'Для более надёжной работы приложения включите управление точными будильниками.';

  @override
  String get exactAlarmError =>
      'Не удалось открыть экран точных будильников на этом устройстве.';

  @override
  String get batteryOptimizationError =>
      'Не удалось открыть экран информации на этом устройстве.';

  @override
  String get batteryOptimizationSubtitle =>
      'Также стоит отключить оптимизацию батареи.';

  @override
  String get privacyPolicyTitle => 'Политика конфиденциальности';

  @override
  String get termsAndConditionsTitle => 'Условия использования';
}
