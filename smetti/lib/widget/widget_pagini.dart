import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';

class WidgetPagine {
  static Widget buildDropdownFrequenza({
    required AppLocalizations l10n,
    required String? frequenzaSelezionata,
    required ValueChanged<String> onChanged,
  }) {
    final frequencyOptions = <MapEntry<String, String>>[
      MapEntry('15m', l10n.frequency15),
      MapEntry('30m', l10n.frequency30),
      MapEntry('45m', l10n.frequency45),
      MapEntry('1h', l10n.frequency1h),
      MapEntry('2h', l10n.frequency2h),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: frequenzaSelezionata,
          isExpanded: true,
          dropdownColor: Colors.grey.shade900,
          iconEnabledColor: Colors.white,
          hint: Text(
            l10n.selectFrequencyHint,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          onChanged: (String? nuovoValore) {
            if (nuovoValore == null) return;
            onChanged(nuovoValore);
          },
          items: frequencyOptions
              .map(
                (frequenza) => DropdownMenuItem<String>(
                  value: frequenza.key,
                  child: Text(frequenza.value),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  static Widget buildDropdownCoda({
    required AppLocalizations l10n,
    required int? notificheInCodaSelezionate,
    required ValueChanged<int> onChanged,
  }) {
    String labelPerNumero(int numero) {
      switch (numero) {
        case 1:
        return l10n.queue1;
        case 10:
          return l10n.queue10;
        case 20:
          return l10n.queue20;
        case 30:
          return l10n.queue30;
        default:
          return '$numero';
      }
    }

    final codeNotifiche = <int>[1, 10, 20, 30];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: notificheInCodaSelezionate,
          isExpanded: true,
          dropdownColor: Colors.grey.shade900,
          iconEnabledColor: Colors.white,
          hint: Text(
            l10n.selectQueueHint,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          onChanged: (int? nuovoValore) {
            if (nuovoValore == null) return;
            onChanged(nuovoValore);
          },
          items: codeNotifiche
              .map(
                (numero) => DropdownMenuItem<int>(
                  value: numero,
                  child: Text(labelPerNumero(numero)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  static Widget buildRisparmioCard({
    required AppLocalizations l10n,
    required double Function(int giorni) risparmioPer,
    required String Function(double valore) euro,
  }) {
    final dati = <MapEntry<String, int>>[
      MapEntry(l10n.days30, 30),
      MapEntry(l10n.days60, 60),
      MapEntry(l10n.days90, 90),
      MapEntry(l10n.months6, 180),
      MapEntry(l10n.year1, 365),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.savingsEstimatedTitle,
            style: GoogleFonts.exo(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          ...dati.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(
                    item.key,
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    euro(risparmioPer(item.value)),
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}