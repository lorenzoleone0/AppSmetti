import 'dart:math' as math;

import 'package:flutter/material.dart';
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: frequenzaSelezionata,
          isExpanded: true,
          dropdownColor: Colors.grey.shade900,
          iconEnabledColor: Colors.white,
          hint: Text(
            l10n.selectFrequencyHint,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
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
        default:
          return '$numero';
      }
    }

    final codeNotifiche = <int>[1, 10, 20];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: notificheInCodaSelezionate,
          isExpanded: true,
          dropdownColor: Colors.grey.shade900,
          iconEnabledColor: Colors.white,
          hint: Text(
            l10n.selectQueueHint,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
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

  static double _measureTextWidth(String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return painter.width;
  }

  static double _estimateSavingsWidth({
    required List<String> amountTexts,
    required TextStyle style,
  }) {
    const symbols = <String>['¥€£\$', '¥€\$', '¥£\$', '£', '€', '\$', '¥'];

    var maxWidth = 0.0;

    for (final amount in amountTexts) {
      for (final symbol in symbols) {
        final candidate = '$symbol $amount';
        final width = _measureTextWidth(candidate, style);
        if (width > maxWidth) {
          maxWidth = width;
        }
      }
    }

    return maxWidth + 2;
  }

  static Widget buildRisparmioCard({
    required AppLocalizations l10n,
    required double Function(int giorni) risparmioPer,
    required String Function(double valore) euro,
    ValueChanged<int>? onAmountDoubleTap,
    int animationStyleIndex = 0,
    int? sparkTargetDays,
    int sparkToken = 0,
  }) {
    final dati = <MapEntry<String, int>>[
      MapEntry(l10n.days30, 30),
      MapEntry(l10n.days60, 60),
      MapEntry(l10n.days90, 90),
      MapEntry(l10n.months6, 180),
      MapEntry(l10n.year1, 365),
    ];

    final valueStyle = const TextStyle(
    fontFamily: 'Exo',
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    final amountTexts = dati
        .map((item) => euro(risparmioPer(item.value)))
        .toList(growable: false);

    final maxValueWidth = _estimateSavingsWidth(
      amountTexts: amountTexts,
      style: valueStyle,
    );

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
            style: const TextStyle(
    fontFamily: 'Exo',
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
                    style: const TextStyle(
    fontFamily: 'Exo',color: Colors.white, fontSize: 15),
                  ),
                  const Spacer(),
                  SavingsAmountRow(
                    text: euro(risparmioPer(item.value)),
                    displayWidth: maxValueWidth,
                    isSparkTarget: sparkTargetDays == item.value,
                    sparkToken: sparkToken,
                    animationStyleIndex: animationStyleIndex,
                    onDoubleTap: onAmountDoubleTap == null
                        ? null
                        : () => onAmountDoubleTap(item.value),
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

class SavingsAmountRow extends StatefulWidget {
  const SavingsAmountRow({
    super.key,
    required this.text,
    required this.displayWidth,
    required this.isSparkTarget,
    required this.sparkToken,
    required this.animationStyleIndex,
    this.onDoubleTap,
  });

  final String text;
  final double displayWidth;
  final bool isSparkTarget;
  final int sparkToken;
  final int animationStyleIndex;
  final VoidCallback? onDoubleTap;

  @override
  State<SavingsAmountRow> createState() => _SavingsAmountRowState();
}

class _SavingsAmountRowState extends State<SavingsAmountRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sparkController;
  final math.Random _rng = math.Random();

  Offset? _sparkOrigin;
  int _lastSparkToken = -1;
  List<_SparkParticle> _particles = const [];

  @override
  void initState() {
    super.initState();
    _sparkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _maybeStartSpark();
  }

  @override
  void didUpdateWidget(covariant SavingsAmountRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeStartSpark();
  }

  void _maybeStartSpark() {
    if (!widget.isSparkTarget || widget.sparkToken == _lastSparkToken) return;

    _lastSparkToken = widget.sparkToken;
    _particles = List.generate(8, (index) {
      return _SparkParticle(
        angle: _rng.nextDouble() * math.pi * 2,
        distance: 10 + _rng.nextDouble() * 14,
        size: 2.0 + _rng.nextDouble() * 2.5,
        lift: 6 + _rng.nextDouble() * 10,
      );
    });

    _sparkController.forward(from: 0);
    setState(() {});
  }

  @override
  void dispose() {
    _sparkController.dispose();
    super.dispose();
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
  switch (widget.animationStyleIndex % 5) {
    case 0:
      return FadeTransition(opacity: animation, child: child);

    case 1:
      final offset = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation);
      return SlideTransition(
        position: offset,
        child: FadeTransition(opacity: animation, child: child),
      );

    case 2:
      final scale = Tween<double>(begin: 0.85, end: 1.0).animate(animation);
      return ScaleTransition(
        scale: scale,
        child: FadeTransition(opacity: animation, child: child),
      );

    case 3:
      final rotate = Tween<double>(begin: 0.20, end: 0.0).animate(animation);
      return RotationTransition(
        turns: rotate,
        child: FadeTransition(opacity: animation, child: child),
      );

    default:
      final offset = Tween<Offset>(
        begin: const Offset(-0.14, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
      );

      return SlideTransition(
        position: offset,
        child: FadeTransition(opacity: animation, child: child),
      );
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTapDown: (details) {
        setState(() {
          _sparkOrigin = details.localPosition;
        });
      },
      onDoubleTap: widget.onDoubleTap,
      child: SizedBox(
        width: widget.displayWidth,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: _buildTransition(child, animation),
                );
              },
              child: Text(
                widget.text,
                key: ValueKey<String>(widget.text),
                textAlign: TextAlign.right,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontFamily: 'Exo',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _sparkController,
                  builder: (context, child) {
                    final t = Curves.easeOut.transform(_sparkController.value);
                    if (t <= 0 || t >= 1 || _particles.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final center =
                            _sparkOrigin ??
                            Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2,
                            );

                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            for (final p in _particles)
                              Positioned(
                                left:
                                    center.dx +
                                    math.cos(p.angle) * p.distance * t -
                                    p.size / 2,
                                top:
                                    center.dy +
                                    math.sin(p.angle) * p.distance * t -
                                    p.lift * t * t -
                                    p.size / 2,
                                child: Opacity(
                                  opacity: (1 - t).clamp(0.0, 1.0),
                                  child: Transform.scale(
                                    scale: 0.7 + (1 - t) * 0.6,
                                    child: Container(
                                      width: p.size,
                                      height: p.size,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparkParticle {
  const _SparkParticle({
    required this.angle,
    required this.distance,
    required this.size,
    required this.lift,
  });

  final double angle;
  final double distance;
  final double size;
  final double lift;
}
