// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Deja de Fumar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get changeGradientTitle => 'Cambiar degradado';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get selectLanguageHint => 'Selecciona un idioma';

  @override
  String get savingsSectionTitle => 'Ahorro';

  @override
  String get savingsTileTitle => 'Precio del paquete y consumo medio';

  @override
  String get savingsTileSubtitle =>
      'Modifica los datos para calcular tu ahorro';

  @override
  String get homeIntroPart1 =>
      'Configura la frecuencia\nde las notificaciones para ';

  @override
  String get homeIntroSmettere => 'DEJAR';

  @override
  String get homeIntroPart3 => ' de fumar';

  @override
  String get selectFrequencyHint => 'Selecciona la frecuencia';

  @override
  String get selectQueueHint =>
      'Selecciona la cantidad de notificaciones en cola';

  @override
  String get frequency15 => 'Cada 15 minutos';

  @override
  String get frequency30 => 'Cada 30 minutos';

  @override
  String get frequency45 => 'Cada 45 minutos';

  @override
  String get frequency1h => 'Cada 1 hora';

  @override
  String get frequency2h => 'Cada 2 horas';

  @override
  String get queue1 => '1 notificación';

  @override
  String get queue10 => '10 notificaciones en cola';

  @override
  String get queue20 => '20 notificaciones en cola';

  @override
  String get savingsEstimatedTitle => 'Ahorro estimado';

  @override
  String get days30 => '30 días';

  @override
  String get days60 => '60 días';

  @override
  String get days90 => '90 días';

  @override
  String get months6 => '6 meses';

  @override
  String get year1 => '1 año';

  @override
  String get resetNotificationTitle => 'Restablecer notificación';

  @override
  String get resetFrequencyTitle => 'Restablecer frecuencia';

  @override
  String get resetFrequency => 'Restablecer la frecuencia';

  @override
  String get savingsPageTitle => 'Tu ahorro';

  @override
  String get savingsIntro =>
      'Introduce el precio medio del paquete y el consumo medio.';

  @override
  String get packPriceLabel => 'Precio medio del paquete';

  @override
  String get averageConsumptionLabel => 'Consumo medio paquete/cigarrillos';

  @override
  String get averageConsumptionSubtitle =>
      'Tomando como referencia un paquete de 20 cigarrillos,\n1 cigarrillo = 0,05 paquete\n1,00 = 1 paquete';

  @override
  String get consumptionReferenceLabel => 'La cantidad media se refiere a';

  @override
  String get invalidNumberError => 'Introduce un número válido mayor que 0';

  @override
  String get saveAndContinue => 'Guardar y continuar';

  @override
  String get consumptionOption1Day => 'Un día';

  @override
  String get consumptionOption2Days => 'Dos días';

  @override
  String get consumptionOption3Days => 'Tres días';

  @override
  String get consumptionOption4Days => 'Cuatro días';

  @override
  String get consumptionOption5Days => 'Cinco días';

  @override
  String get consumptionOption1Week => 'Una semana';

  @override
  String get gradientRed => 'Rojo';

  @override
  String get gradientBlue => 'Azul';

  @override
  String get gradientGreen => 'Verde';

  @override
  String get gradientPurple => 'Morado';

  @override
  String get gradientOrange => 'Naranja';

  @override
  String get gradientYellow => 'Amarillo';

  @override
  String get gradientGray => 'Gris';

  @override
  String get optimizationSectionTitle => 'Optimizar la aplicación';

  @override
  String get exactAlarmSubtitle =>
      'Para un funcionamiento más fiable de la app, activa la gestión de alarmas exactas.';

  @override
  String get exactAlarmError =>
      'No se puede abrir la pantalla de alarmas exactas en este dispositivo.';

  @override
  String get batteryOptimizationError =>
      'No se puede abrir la pantalla de información en este dispositivo.';

  @override
  String get batteryOptimizationSubtitle =>
      'También conviene desactivar la optimización de batería.';

  @override
  String get privacyPolicyTitle => 'Política de privacidad';

  @override
  String get termsAndConditionsTitle => 'Términos y condiciones';
}
