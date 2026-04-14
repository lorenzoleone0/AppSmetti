import 'package:flutter/material.dart';

class SfumaturaOpzione {
  final String nome;
  final Color colore;

  const SfumaturaOpzione({
    required this.nome,
    required this.colore,
  });
}

const List<SfumaturaOpzione> opzioniSfumatura = [
  SfumaturaOpzione(
    nome: 'Rosso',
    colore: Color.fromARGB(255, 87, 1, 1),
  ),
  SfumaturaOpzione(
    nome: 'Verde',
    colore: Color.fromARGB(255, 1, 87, 1),
  ),
  SfumaturaOpzione(
    nome: 'Blu',
    colore: Color.fromARGB(255, 1, 1, 87),
  ),
  SfumaturaOpzione(
    nome: 'Viola',
    colore: Color.fromARGB(255, 60, 1, 87),
  ),
  SfumaturaOpzione(
    nome: 'Arancione',
    colore: Color.fromARGB(255, 87, 42, 1),
  ),
  SfumaturaOpzione(
    nome: 'Grigio',
    colore: Color.fromARGB(255, 55, 55, 55),
  ),
];