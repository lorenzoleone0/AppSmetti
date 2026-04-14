import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pagina_impostazioni.dart';
import 'colori.dart';
import 'app_storage.dart';
import 'notifiche.dart';

class PaginaIniziale extends StatefulWidget {
  const PaginaIniziale({super.key});

  @override
  State<PaginaIniziale> createState() => _PaginaInizialeState();
}

class _PaginaInizialeState extends State<PaginaIniziale>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _rainbowController;
  late Animation<Color?> _backgroundColorAnimation;

  final List<String> _frequenze = const [
    'Ogni 15 minuti',
    'Ogni 30 minuti',
    'Ogni 45 minuti',
    'Ogni 1 ora',
    'Ogni 2 ore',
    'Ogni 4 ore',
    'Ogni 8 ore',
  ];

  double? _costoPacchetto;
  double? _quantitaMedia;
  int? _consumoGiorni;

  String? _frequenzaSelezionata;
  Color _coloreSfumatura = const Color.fromARGB(255, 87, 1, 1);

  TextStyle get _testoBase => GoogleFonts.exo(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.4,
      );

  @override
  void initState() {
    super.initState();

    _frequenzaSelezionata = _frequenze.first;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _rainbowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _creaAnimazioneSfondo();
    _caricaPreferenze();
  }

  void _creaAnimazioneSfondo() {
    _backgroundColorAnimation = ColorTween(
      begin: Colors.black,
      end: _coloreSfumatura,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  double? get _spesaGiornaliera {
    if (_costoPacchetto == null ||
        _quantitaMedia == null ||
        _consumoGiorni == null) {
      return null;
    }

    return (_costoPacchetto! * _quantitaMedia!) / _consumoGiorni!;
  }

  double _risparmioPer(int giorni) {
    final base = _spesaGiornaliera;
    if (base == null) return 0;
    return base * giorni;
  }

  String _euro(double valore) => '€ ${valore.toStringAsFixed(2)}';

  @override
  void dispose() {
    _controller.dispose();
    _rainbowController.dispose();
    super.dispose();
  }

  PageRouteBuilder<bool> _slideDaSinistra(Widget pagina) {
    return PageRouteBuilder<bool>(
      pageBuilder: (context, animation, secondaryAnimation) => pagina,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<void> _apriImpostazioni() async {
    final changed = await Navigator.of(context).push<bool>(
      _slideDaSinistra(
        PaginaImpostazioni(
          coloreSelezionato: _coloreSfumatura,
          opzioniSfumatura: opzioniSfumatura,
          onColoreChanged: (Color nuovoColore) async {
            setState(() {
              _coloreSfumatura = nuovoColore;
              _creaAnimazioneSfondo();
            });
            await AppStorage.saveGradientColor(nuovoColore);
          },
        ),
      ),
    );

    if (changed == true && mounted) {
      await _caricaPreferenze();
    }
  }

  Future<void> _caricaPreferenze() async {
    final frequenzaSalvata = await AppStorage.loadFrequency();
    final coloreSalvato = await AppStorage.loadGradientColor();

    final costoPacchetto = await AppStorage.loadPackPrice();
    final quantitaMedia = await AppStorage.loadAverageAmount();
    final consumoGiorni = await AppStorage.loadConsumptionDays();

    if (!mounted) return;

    setState(() {
      if (frequenzaSalvata != null && _frequenze.contains(frequenzaSalvata)) {
        _frequenzaSelezionata = frequenzaSalvata;
      }

      if (coloreSalvato != null) {
        _coloreSfumatura = coloreSalvato;
        _creaAnimazioneSfondo();
      }

      _costoPacchetto = costoPacchetto;
      _quantitaMedia = quantitaMedia;
      _consumoGiorni = consumoGiorni;
    });

    /* if (_frequenzaSelezionata != null) {
      await ServizioNotifiche.instance.programmaPromemoria(
        _frequenzaSelezionata!,
      );
    } */
   await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
  }

  Widget _buildRisparmioCard() {
    final dati = <MapEntry<String, int>>[
      const MapEntry('30 giorni', 30),
      const MapEntry('60 giorni', 60),
      const MapEntry('90 giorni', 90),
      const MapEntry('6 mesi', 180),
      const MapEntry('1 anno', 365),
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
            'Risparmio stimato',
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
                    _euro(_risparmioPer(item.value)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings_rounded, color: Colors.white),
          onPressed: _apriImpostazioni,
        ),
      ),
      body: AnimatedBuilder(
        animation: _backgroundColorAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  _backgroundColorAnimation.value ?? Colors.black,
                  Colors.black,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: _testoBase,
                            children: [
                              const TextSpan(
                                text: 'Imposta la frequenza\ndelle notifiche, per ',
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: AnimatedBuilder(
                                  animation: _rainbowController,
                                  builder: (context, child) {
                                    return ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: const [
                                            Color(0xFFFF004C),
                                            Color(0xFFFFA500),
                                            Color(0xFFFFFF00),
                                            Color(0xFF00FF6A),
                                            Color(0xFF00C8FF),
                                            Color(0xFF6A00FF),
                                            Color(0xFFFF004C),
                                          ],
                                          stops: const [
                                            0.0,
                                            0.16,
                                            0.33,
                                            0.5,
                                            0.66,
                                            0.83,
                                            1.0,
                                          ],
                                          transform: GradientRotation(
                                            _rainbowController.value * 2 * math.pi,
                                          ),
                                        ).createShader(bounds);
                                      },
                                      child: child,
                                    );
                                  },
                                  child: Text(
                                    'SMETTERE',
                                    style: _testoBase.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(text: ' di fumare'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
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
                              value: _frequenzaSelezionata,
                              isExpanded: true,
                              dropdownColor: Colors.grey.shade900,
                              iconEnabledColor: Colors.white,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              onChanged: (String? nuovoValore) async {
                                if (nuovoValore == null) return;

                                setState(() {
                                  _frequenzaSelezionata = nuovoValore;
                                });

                                await AppStorage.saveFrequency(nuovoValore);
                                await ServizioNotifiche.instance.programmaPromemoria(
                                  nuovoValore,
                                );
                              },
                              items: _frequenze
                                  .map(
                                    (frequenza) => DropdownMenuItem<String>(
                                      value: frequenza,
                                      child: Text(frequenza),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (_spesaGiornaliera != null) _buildRisparmioCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}