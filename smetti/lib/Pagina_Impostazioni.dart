import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colori.dart';
import 'Pagina_Risparmio.dart';

class PaginaImpostazioni extends StatelessWidget {
  const PaginaImpostazioni({
    super.key,
    required this.coloreSelezionato,
    required this.opzioniSfumatura,
    required this.onColoreChanged,
  });

  final Color coloreSelezionato;
  final List<SfumaturaOpzione> opzioniSfumatura;
  final ValueChanged<Color> onColoreChanged;

  @override
  Widget build(BuildContext context) {
    final SfumaturaOpzione? opzioneAttuale = opzioniSfumatura.isNotEmpty
        ? opzioniSfumatura.firstWhere(
            (opzione) => opzione.colore.value == coloreSelezionato.value,
            orElse: () => opzioniSfumatura.first,
          )
        : null;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          'Impostazioni',
          style: GoogleFonts.exo(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cambia sfumatura',
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
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: opzioneAttuale?.nome,
                  isExpanded: true,
                  dropdownColor: Colors.grey.shade900,
                  iconEnabledColor: Colors.white,
                  style: GoogleFonts.exo(fontWeight: FontWeight.w600),
                  onChanged: (String? nuovoValore) {
                    if (nuovoValore == null) return;

                    final SfumaturaOpzione opzioneSelezionata =
                        opzioniSfumatura.firstWhere(
                      (opzione) => opzione.nome == nuovoValore,
                    );

                    onColoreChanged(opzioneSelezionata.colore);
                    Navigator.pop(context);
                  },
                  items: opzioniSfumatura
                      .map(
                        (opzione) => DropdownMenuItem<String>(
                          value: opzione.nome,
                          child: Text(opzione.nome),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'Risparmio',
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
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.savings_outlined, color: Colors.white),
                title: Text(
                  'Costo pacchetto e consumo medio',
                  style: GoogleFonts.exo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Modifica i dati per calcolare il risparmio',
                  style: GoogleFonts.exo(
                    color: Colors.white70,
                  ),
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