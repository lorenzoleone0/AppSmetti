import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colori.dart';
import 'Pagina_Risparmio.dart';

class PaginaImpostazioni extends StatefulWidget {
  const PaginaImpostazioni({
    super.key,
    required this.coloreSelezionato,
    required this.opzioniSfumatura,
    required this.onColoreChanged,
    required this.linguaSelezionata,
    required this.onLinguaChanged,
  });

  final Color coloreSelezionato;
  final List<SfumaturaOpzione> opzioniSfumatura;
  final ValueChanged<Color> onColoreChanged;

  final String? linguaSelezionata;
  final ValueChanged<String> onLinguaChanged;

  @override
  State<PaginaImpostazioni> createState() => _PaginaImpostazioniState();
}

class _PaginaImpostazioniState extends State<PaginaImpostazioni> {
  String? _linguaLocale;

  @override
  void initState() {
    super.initState();
    _linguaLocale = widget.linguaSelezionata;
  }

  @override
  void didUpdateWidget(covariant PaginaImpostazioni oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.linguaSelezionata != widget.linguaSelezionata) {
      _linguaLocale = widget.linguaSelezionata;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final SfumaturaOpzione? opzioneAttuale = widget.opzioniSfumatura.isNotEmpty
        ? widget.opzioniSfumatura.firstWhere(
            (opzione) => opzione.colore.value == widget.coloreSelezionato.value,
            orElse: () => widget.opzioniSfumatura.first,
          )
        : null;

    final lingue = <MapEntry<String, String>>[
      const MapEntry('it', 'Italiano'),
      const MapEntry('en', 'English'),
      const MapEntry('es', 'Español'),
      const MapEntry('fr', 'Français'),
      const MapEntry('de', 'Deutsch'),
      const MapEntry('ru', 'Русский'),
      const MapEntry('zh', '中文'),
      const MapEntry('ko', '한국어'),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          l10n.settingsTitle,
          style: GoogleFonts.exo(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.changeGradientTitle,
              style: GoogleFonts.exo(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: opzioneAttuale?.id,
                  isExpanded: true,
                  dropdownColor: Colors.grey.shade900,
                  iconEnabledColor: Colors.white,
                  style: GoogleFonts.exo(fontWeight: FontWeight.w600),
                  onChanged: (String? nuovoValore) {
                    if (nuovoValore == null) return;

                    final SfumaturaOpzione opzioneSelezionata =
                        widget.opzioniSfumatura.firstWhere(
                      (opzione) => opzione.id == nuovoValore,
                    );

                    widget.onColoreChanged(opzioneSelezionata.colore);
                    Navigator.pop(context);
                  },
                  items: widget.opzioniSfumatura
                      .map(
                        (opzione) => DropdownMenuItem<String>(
                          value: opzione.id,
                          child: Text(labelSfumatura(l10n, opzione.id)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.languageTitle,
              style: GoogleFonts.exo(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _linguaLocale,
                  isExpanded: true,
                  dropdownColor: Colors.grey.shade900,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    l10n.selectLanguageHint,
                    style: GoogleFonts.exo(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: GoogleFonts.exo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (String? nuovoValore) {
                    if (nuovoValore == null) return;

                    setState(() {
                      _linguaLocale = nuovoValore;
                    });

                    widget.onLinguaChanged(nuovoValore);
                  },
                  items: lingue
                      .map(
                        (lingua) => DropdownMenuItem<String>(
                          value: lingua.key,
                          child: Text(lingua.value),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.savingsSectionTitle,
              style: GoogleFonts.exo(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: ListTile(
                leading: const Icon(Icons.savings_outlined, color: Colors.white),
                title: Text(
                  l10n.savingsTileTitle,
                  style: GoogleFonts.exo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.savingsTileSubtitle,
                  style: GoogleFonts.exo(color: Colors.white70),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () async {
                  final changed = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => const PaginaRisparmio(),
                    ),
                  );

                  if (changed == true && context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}