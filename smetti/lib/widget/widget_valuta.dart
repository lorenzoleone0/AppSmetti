import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ValutaPopupMenu extends StatelessWidget {
  const ValutaPopupMenu({
    super.key,
    required this.currentCode,
    required this.onSelected,
    this.tooltip = '',
  });

  final String currentCode;
  final ValueChanged<String> onSelected;
  final String tooltip;

  static const Map<String, String> valuteDisponibili = {
    'EUR': '€',
    'USD': '\$',
    'AUD': '\$',
    'CAD': '\$',
    'GBP': '£',
    'KRW': '₩',
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: tooltip,
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: onSelected,
      itemBuilder: (context) => valuteDisponibili.entries
          .map(
            (entry) => PopupMenuItem<String>(
              value: entry.key,
              child: Text(
                '${entry.key} - ${entry.value}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentCode,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Icon(Icons.expand_more, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

String formatCurrencyValue(
  double value,
  String localeCode,
  String currencyCode,
) {
  final format = NumberFormat.currency(
    locale: localeCode,
    name: currencyCode,
    decimalDigits: 2,
  );

  return format.format(value);
}
