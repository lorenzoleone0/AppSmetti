import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'app_locale.dart';
import 'app_storage.dart';
import 'colori.dart';
import 'notifiche.dart';
import 'pagina_impostazioni.dart';
import 'widget/widget_pagini.dart';

class PaginaIniziale extends StatefulWidget {
  const PaginaIniziale({super.key});

  @override
  State<PaginaIniziale> createState() => _PaginaInizialeState();
}

class _PaginaInizialeState extends State<PaginaIniziale>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;
  late final AnimationController _rainbowController;
  late Animation<Color?> _backgroundColorAnimation;

  double? _costoPacchetto;
  double? _quantitaMedia;
  int? _consumoGiorni;

  String? _frequenzaSelezionata;
  int? _notificheInCodaSelezionate;
  String? _linguaSelezionata;

  Color _coloreSfumatura = const Color.fromARGB(255, 87, 1, 1);

  TextStyle get _testoBase => const TextStyle(
    fontFamily: 'Exo',
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.4,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

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

  final math.Random _rng = math.Random();

  static const List<String> _savingsSymbols = [
    '¥€£\$',
    '¥€\$',
    '¥£\$',
    '£',
    '€',
    '\$',
    '¥',
    '₽',
  ];

  int _savingsEggIndex = 0;
  int _savingsAnimationIndex = 0;
  int _savingsSparkToken = 0;
  int? _sparkTargetDays;

  //String _valuta(double valore) => '€ ${valore.toStringAsFixed(2)}';

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _rainbowController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controllaPromemoriaTerminato();
    }
  }

  String _linguaAttivaOS() {
    const supportate = ['it', 'en', 'es', 'fr', 'de', 'ru', 'pt', 'ko'];
    final code = AppLocaleController.locale.value.languageCode;
    return supportate.contains(code) ? code : 'en';
  }

  int _nextDifferentIndex(int current, int maxExclusive) {
  if (maxExclusive <= 1) return 0;
  final next = _rng.nextInt(maxExclusive - 1);
  return next >= current ? next + 1 : next;
}

void _toggleSavingsEasterEgg(int giorni) {
  setState(() {
    _savingsEggIndex = (_savingsEggIndex + 1) % _savingsSymbols.length;
    _savingsAnimationIndex = _nextDifferentIndex(_savingsAnimationIndex, 4);
    _sparkTargetDays = giorni;
    _savingsSparkToken++;
  });

  AppStorage.saveSavingsEggIndex(_savingsEggIndex);
}

  String _valuta(double valore) =>
    '${_savingsSymbols[_savingsEggIndex]} ${valore.toStringAsFixed(2)}';

  Future<void> _controllaPromemoriaTerminato() async {
    final resettato = await ServizioNotifiche.instance
        .resettaPromemoriaSeTerminato();

    if (!mounted || !resettato) return;

    setState(() {
      _frequenzaSelezionata = null;
      _notificheInCodaSelezionate = null;
    });
  }

  PageRouteBuilder<bool> _slideDaSinistra(Widget pagina) {
    return PageRouteBuilder<bool>(
      pageBuilder: (context, animation, secondaryAnimation) => pagina,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
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
          onLinguaChanged: (String nuovaLingua) async {
            setState(() {
              _linguaSelezionata = nuovaLingua;
            });

            await AppLocaleController.setLanguage(nuovaLingua);
            await ServizioNotifiche.instance
                .aggiornaNotificheDopoCambioLingua();
          },
        ),
      ),
    );

    if (changed == true && mounted) {
      await _caricaPreferenze();
    }
  }

  Future<void> _caricaPreferenze() async {
    final frequenzaSalvata = _normalizeFrequencyCode(
      await AppStorage.loadFrequency(),
    );

    final notificheSalvate = await AppStorage.loadNotificationQueue();
    final linguaSalvata = await AppStorage.loadLanguage();
    final coloreSalvato = await AppStorage.loadGradientColor();

    final costoPacchetto = await AppStorage.loadPackPrice();
    final quantitaMedia = await AppStorage.loadAverageAmount();
    final consumoGiorni = await AppStorage.loadConsumptionDays();
    final savingsEggIndex = await AppStorage.loadSavingsEggIndex();

    if (!mounted) return;

    final linguaDaMostrare = linguaSalvata ?? _linguaAttivaOS();

    setState(() {
      _frequenzaSelezionata = frequenzaSalvata;
      _notificheInCodaSelezionate = notificheSalvate;
      _linguaSelezionata = linguaSalvata;

      _savingsEggIndex = savingsEggIndex % _savingsSymbols.length;

      if (coloreSalvato != null) {
        _coloreSfumatura = coloreSalvato;
        _creaAnimazioneSfondo();
      }

      _costoPacchetto = costoPacchetto;
      _quantitaMedia = quantitaMedia;
      _consumoGiorni = consumoGiorni;
    });

    if (linguaSalvata == null) {
      await AppStorage.saveLanguage(linguaDaMostrare);
      await AppLocaleController.setLanguage(linguaDaMostrare);
    }

    await ServizioNotifiche.instance.sincronizzaPromemoriaAllAvvio();
    await _controllaPromemoriaTerminato();
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
                              TextSpan(text: l10n.homeIntroPart1),
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
                                            _rainbowController.value *
                                                2 *
                                                math.pi,
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
                        WidgetPagine.buildDropdownFrequenza(
                          l10n: l10n,
                          frequenzaSelezionata: _frequenzaSelezionata,
                          onChanged: (nuovoValore) async {
                            setState(() {
                              _frequenzaSelezionata = nuovoValore;
                            });
                            await _salvaEProgrammaNotifiche();
                          },
                        ),
                        const SizedBox(height: 16),
                        WidgetPagine.buildDropdownCoda(
                          l10n: l10n,
                          notificheInCodaSelezionate:
                              _notificheInCodaSelezionate,
                          onChanged: (nuovoValore) async {
                            setState(() {
                              _notificheInCodaSelezionate = nuovoValore;
                            });
                            await _salvaEProgrammaNotifiche();
                          },
                        ),
                        const SizedBox(height: 24),
                        if (_spesaGiornaliera != null)
                          WidgetPagine.buildRisparmioCard(
                            l10n: l10n,
                            risparmioPer: _risparmioPer,
                            euro: _valuta,
                            onAmountDoubleTap: _toggleSavingsEasterEgg,
                            animationStyleIndex: _savingsAnimationIndex,
                            sparkTargetDays: _sparkTargetDays,
                            sparkToken: _savingsSparkToken,
                          ),
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
