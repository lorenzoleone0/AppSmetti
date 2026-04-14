import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_storage.dart';
import 'package:smetti/Pagina_Iniziale.dart';


class PaginaRisparmio extends StatefulWidget {
  const PaginaRisparmio({super.key, this.fromFirstLaunch = false,});

final bool fromFirstLaunch;

  @override
  State<PaginaRisparmio> createState() => _PaginaRisparmioState();
}

class _PaginaRisparmioState extends State<PaginaRisparmio> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _prezzoController = TextEditingController();
  final TextEditingController _consumoController = TextEditingController();

  double _prezzoPacchetto = 5.50;
  double _quantitaMedia = 1.0;
  int _consumoGiorni = 1;

  bool _caricamento = true;

  final List<Map<String, dynamic>> _opzioniConsumo = const [
    {'label': 'Un giorno', 'days': 1},
    {'label': 'Due giorni', 'days': 2},
    {'label': 'Tre giorni', 'days': 3},
    {'label': 'Quattro giorni', 'days': 4},
    {'label': 'Cinque giorni', 'days': 5},
    {'label': 'Una settimana', 'days': 7},
  ];

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  @override
  void dispose() {
    _prezzoController.dispose();
    _consumoController.dispose();
    super.dispose();
  }

  Future<void> _caricaDati() async {
    final prezzo = await AppStorage.loadPackPrice();
    final quantita = await AppStorage.loadAverageAmount();
    final giorni = await AppStorage.loadConsumptionDays();

    if (!mounted) return;

    setState(() {
      if (prezzo != null) _prezzoPacchetto = prezzo;
      if (quantita != null) _quantitaMedia = quantita;
      if (giorni != null) _consumoGiorni = giorni;

      _prezzoController.text = _prezzoPacchetto.toStringAsFixed(2);
      _consumoController.text = _quantitaMedia.toStringAsFixed(2);

      _caricamento = false;
    });
  }

  double? _parseNumero(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  void _syncPrezzoDaTesto(String value) {
    final parsed = _parseNumero(value);
    if (parsed == null) return;
    setState(() {
      _prezzoPacchetto = parsed;
    });
  }

  void _syncConsumoDaTesto(String value) {
    final parsed = _parseNumero(value);
    if (parsed == null) return;
    setState(() {
      _quantitaMedia = parsed;
    });
  }

  void _incrementaPrezzo() {
    setState(() {
      _prezzoPacchetto = (_prezzoPacchetto + 0.01).clamp(0, 9999);
      _prezzoController.text = _prezzoPacchetto.toStringAsFixed(2);
    });
  }

  void _decrementaPrezzo() {
    setState(() {
      _prezzoPacchetto = (_prezzoPacchetto - 0.01).clamp(0, 9999);
      _prezzoController.text = _prezzoPacchetto.toStringAsFixed(2);
    });
  }

  void _incrementaConsumo() {
    setState(() {
      _quantitaMedia = (_quantitaMedia + 0.01).clamp(0, 9999);
      _consumoController.text = _quantitaMedia.toStringAsFixed(2);
    });
  }

  void _decrementaConsumo() {
    setState(() {
      _quantitaMedia = (_quantitaMedia - 0.01).clamp(0, 9999);
      _consumoController.text = _quantitaMedia.toStringAsFixed(2);
    });
  }

  double _spesaGiornaliera() {
    return (_prezzoPacchetto * _quantitaMedia) / _consumoGiorni;
  }

  double _risparmioPerGiorni(int giorni) {
    return _spesaGiornaliera() * giorni;
  }

  String _euro(double valore) => '€ ${valore.toStringAsFixed(2)}';

  Future<void> _salva() async {
  if (!(_formKey.currentState?.validate() ?? false)) return;

  final prezzo = _parseNumero(_prezzoController.text);
  final consumo = _parseNumero(_consumoController.text);

  if (prezzo == null || consumo == null) return;

  await AppStorage.saveSavingsConfig(
    packPrice: prezzo,
    averageAmount: consumo,
    consumptionDays: _consumoGiorni,
  );

  await AppStorage.setOnboardingCompleted();

if (!mounted) return;

if (widget.fromFirstLaunch) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => const PaginaIniziale(),
    ),
  );
} else {
  Navigator.of(context).pop(true);
}
}

  Widget _buildInputCard({
    required String label,
    required String subtitle,
    required TextEditingController controller,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
    required String? Function(String?) validator,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
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
            label,
            style: GoogleFonts.exo(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.exo(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                onPressed: onMinus,
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.white,
                iconSize: 30,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.exo(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: validator,
                  onChanged: onChanged,
                ),
              ),
              IconButton(
                onPressed: onPlus,
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.white,
                iconSize: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavingRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.exo(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Text(
            _euro(value),
            style: GoogleFonts.exo(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_caricamento) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final risparmio30 = _risparmioPerGiorni(30);
    final risparmio60 = _risparmioPerGiorni(60);
    final risparmio90 = _risparmioPerGiorni(90);
    final risparmio180 = _risparmioPerGiorni(180);
    final risparmio365 = _risparmioPerGiorni(365);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          'Il tuo risparmio',
          style: GoogleFonts.exo(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.15,
            colors: [
              Colors.black,
              Colors.black,
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Inserisci il costo medio del pacchetto e il consumo medio.',
                    style: GoogleFonts.exo(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _buildInputCard(
                    label: 'Costo medio del pacchetto',
                    subtitle: '',
                    controller: _prezzoController,
                    onMinus: _decrementaPrezzo,
                    onPlus: _incrementaPrezzo,
                    validator: (value) {
                      final parsed = _parseNumero(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'Inserisci un numero valido maggiore di 0';
                      }
                      return null;
                    },
                    onChanged: _syncPrezzoDaTesto,
                  ),
                  const SizedBox(height: 16),

                  _buildInputCard(
                    label: 'Consumo medio pacchetto/sigarette',
                    subtitle: 'Considerando un pacchetto da 20 sigarette,'
                    '\n1 sigaretta = 0.05 pacchetto'
                    '\n1.00 = 1 pacchetto',
                    controller: _consumoController,
                    onMinus: _decrementaConsumo,
                    onPlus: _incrementaConsumo,
                    validator: (value) {
                      final parsed = _parseNumero(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'Inserisci un numero valido maggiore di 0';
                      }
                      return null;
                    },
                    onChanged: _syncConsumoDaTesto,
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: _consumoGiorni,
                        dropdownColor: Colors.grey.shade900,
                        iconEnabledColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'La quantità media si riferisce a',
                          labelStyle: GoogleFonts.exo(color: Colors.white70),
                        ),
                        style: GoogleFonts.exo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        items: _opzioniConsumo
                            .map(
                              (opzione) => DropdownMenuItem<int>(
                                value: opzione['days'] as int,
                                child: Text(opzione['label'] as String),
                              ),
                            )
                            .toList(),
                        onChanged: (int? valore) {
                          if (valore == null) return;
                          setState(() {
                            _consumoGiorni = valore;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
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
                          'Risparmio stimato',
                          style: GoogleFonts.exo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildSavingRow('30 giorni', risparmio30),
                        _buildSavingRow('60 giorni', risparmio60),
                        _buildSavingRow('90 giorni', risparmio90),
                        _buildSavingRow('6 mesi', risparmio180),
                        _buildSavingRow('1 anno', risparmio365),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _salva,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 87, 1, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: GoogleFonts.exo(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('Salva e continua'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}