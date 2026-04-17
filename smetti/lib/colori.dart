import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class SfumaturaOpzione {
  final String id;
  final Color colore;

  const SfumaturaOpzione({
    required this.id,
    required this.colore,
  });
}

const List<SfumaturaOpzione> opzioniSfumatura = [
  SfumaturaOpzione(id: 'rosso', colore: Color.fromARGB(255, 87, 1, 1)),
  SfumaturaOpzione(id: 'blu', colore: Color.fromARGB(255, 1, 29, 87)),
  SfumaturaOpzione(id: 'verde', colore: Color.fromARGB(255, 1, 87, 42)),
  SfumaturaOpzione(id: 'viola', colore: Color.fromARGB(255, 62, 1, 87)),
  SfumaturaOpzione(id: 'arancione', colore: Color.fromARGB(255, 87, 45, 1)),
  SfumaturaOpzione(id: 'grigio', colore: Color.fromARGB(255, 87, 87, 87)),
];

String labelSfumatura(AppLocalizations l10n, String id) {
  switch (id) {
    case 'rosso':
      return l10n.gradientRed;
    case 'blu':
      return l10n.gradientBlue;
    case 'verde':
      return l10n.gradientGreen;
    case 'viola':
      return l10n.gradientPurple;
    case 'arancione':
      return l10n.gradientOrange;
    case 'grigio':
      return l10n.gradientGray;
    default:
      return id;
  }
}