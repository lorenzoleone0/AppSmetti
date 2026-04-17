import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_locale.dart';
import 'app_storage.dart';
import 'colori.dart';
import 'notifiche.dart';
import 'pagina_impostazioni.dart';

class _FrequencyOption {
  const _FrequencyOption(this.code, this.label);

  final String code;
  final String label;
}

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

  final List<int> _codeNotifiche = const [20, 30, 40, 50, 60];

  double? _costoPacchetto;
  double? _quantitaMedia;
  int? _consumoGiorni;

  String? _frequenzaSelezionata;
  int? _notificheInCodaSelezionate;
  String? _linguaSelezionata;

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

  List<_FrequencyOption> _frequencyOptions(AppLocalizations l10n) => [
        _FrequencyOption('15m', l10n.frequency15),
        _FrequencyOption('30m', l10n.frequency30),
        _FrequencyOption('45m', l10n.frequency45),
        _FrequencyOption('1h', l10n.frequency1h),
        _FrequencyOption('2h', l10n.frequency2h),
        _FrequencyOption('4h', l10n.frequency4h),
        _FrequencyOption('8h', l10n.frequency8h),
      ];

  String? _normalizeFrequencyCode(String? value) {
    switch (value) {
      case '15m':
      case 'Ogni 15 minuti':
        return '15m';
      case '30m':
      case 'Ogni 30 minuti':
        return '30m';
      case '45m':
      case 'Ogni 45 minuti':
        return '45m';
      case '1h':
      case 'Ogni 1 ora':
        return '1h';
      case '2h':
      case 'Ogni 2 ore':
        return '2h';
      case '4h':
      case 'Ogni 4 ore':
        return '4h';
      case '8h':
      case 'Ogni 8 ore':
        return '8h';
      default:
        return null;
    }
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
          linguaSelezionata: _linguaSelezionata,
          onColoreChanged: (Color nuovoColore) {
            setState(() {
              _coloreSfumatura = nuovoColore;
              _creaAnimazioneSfondo();
            });
            AppStorage.saveGradientColor(nuovoColore);
          },
          onLinguaChanged: (String nuovaLingua) {
            setState(() {
              _linguaSelezionata = nuovaLingua;
            });
            AppLocaleController.setLanguage(nuovaLingua);
          },
        ),
      ),
    );

    if (changed == true && mounted) {
      await _caricaPreferenze();
    }
  }

  Future<void> _caricaPreferenze() async {
    final frequenzaSalvata = _normalizeFrequencyCode(await AppStorage.loadFrequency());
    final notificheSalvate = await AppStorage.loadNotificationQueue();
    final linguaSalvata = await AppStorage.loadLanguage();
    final coloreSalvato = await AppStorage.loadGradientColor();

    final costoPacchetto = await AppStorage.loadPackPrice();
    final quantitaMedia = await AppStorage.loadAverageAmount();
    final consumoGiorni = await AppStorage.loadConsumptionDays();

    if (!mounted) return;

    setState(() {
      _frequenzaSelezionata = frequenzaSalvata;
      _notificheInCodaSelezionate = notificheSalvate;
      _linguaSelezionata = linguaSalvata;

      if (coloreSalvato != null) {
        _coloreSfumatura = coloreSalvato;
        _creaAnimazioneSfondo();
      }

      _costoPacchetto = costoPacchetto;
      _quantitaMedia = quantitaMedia;
      _consumoGiorni = consumoGiorni;
    });

    await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
  }

  Future<void> _salvaEProgrammaNotifiche() async {
    if (_frequenzaSelezionata == null || _notificheInCodaSelezionate == null) {
      return;
    }

    await AppStorage.saveFrequency(_frequenzaSelezionata!);
    await AppStorage.saveNotificationQueue(_notificheInCodaSelezionate!);

    await ServizioNotifiche.instance.programmaPromemoria(
      _frequenzaSelezionata!,
    );
  }

  Widget _buildDropdownFrequenza(AppLocalizations l10n) {
    final frequencyOptions = _frequencyOptions(l10n);

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
          value: _frequenzaSelezionata,
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
          onChanged: (String? nuovoValore) async {
            if (nuovoValore == null) return;

            setState(() {
              _frequenzaSelezionata = nuovoValore;
            });

            await _salvaEProgrammaNotifiche();
          },
          items: frequencyOptions
              .map(
                (frequenza) => DropdownMenuItem<String>(
                  value: frequenza.code,
                  child: Text(frequenza.label),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDropdownCoda(AppLocalizations l10n) {
    
  String labelPerNumero(int numero) {
    switch (numero) {
      case 20:
        return l10n.queue20;
      case 30:
        return l10n.queue30;
      case 40:
        return l10n.queue40;
      case 50:
        return l10n.queue50;
      case 60:
        return l10n.queue60;
      default:
        return '$numero';
    }
  }

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
        value: _notificheInCodaSelezionate,
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
        onChanged: (int? nuovoValore) async {
          if (nuovoValore == null) return;

          setState(() {
            _notificheInCodaSelezionate = nuovoValore;
          });

          await _salvaEProgrammaNotifiche();
        },
        items: _codeNotifiche
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

  Widget _buildRisparmioCard(AppLocalizations l10n) {
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
    final l10n = AppLocalizations.of(context)!;

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
                              TextSpan(
                                text: l10n.homeIntroPart1,
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
                                    l10n.homeIntroSmettere,
                                    style: _testoBase.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(text: l10n.homeIntroPart3),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDropdownFrequenza(l10n),
                        const SizedBox(height: 16),
                        _buildDropdownCoda(l10n),
                        const SizedBox(height: 24),
                        if (_spesaGiornaliera != null) _buildRisparmioCard(l10n),
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