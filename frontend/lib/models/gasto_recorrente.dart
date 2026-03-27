// gasto_recorrente.dart
import 'package:flutter/material.dart';

enum FrequenciaGasto { mensal, anual, semanal }

extension FrequenciaLabel on FrequenciaGasto {
  String get label {
    switch (this) {
      case FrequenciaGasto.mensal:
        return 'Mensal';
      case FrequenciaGasto.anual:
        return 'Anual';
      case FrequenciaGasto.semanal:
        return 'Semanal';
    }
  }
}

enum CategoriaGasto { assinatura, moradia, saude, educacao, transporte, outro }

extension CategoriaLabel on CategoriaGasto {
  String get label {
    switch (this) {
      case CategoriaGasto.assinatura:
        return 'Assinatura';
      case CategoriaGasto.moradia:
        return 'Moradia';
      case CategoriaGasto.saude:
        return 'Saúde';
      case CategoriaGasto.educacao:
        return 'Educação';
      case CategoriaGasto.transporte:
        return 'Transporte';
      case CategoriaGasto.outro:
        return 'Outro';
    }
  }

  IconData get icon {
    switch (this) {
      case CategoriaGasto.assinatura:
        return Icons.subscriptions_rounded;
      case CategoriaGasto.moradia:
        return Icons.home_rounded;
      case CategoriaGasto.saude:
        return Icons.favorite_rounded;
      case CategoriaGasto.educacao:
        return Icons.school_rounded;
      case CategoriaGasto.transporte:
        return Icons.directions_car_rounded;
      case CategoriaGasto.outro:
        return Icons.category_rounded;
    }
  }

  Color get color {
    switch (this) {
      case CategoriaGasto.assinatura:
        return const Color(0xFF4361EE);
      case CategoriaGasto.moradia:
        return const Color(0xFF06D6A0);
      case CategoriaGasto.saude:
        return const Color(0xFFEF476F);
      case CategoriaGasto.educacao:
        return const Color(0xFFFFD166);
      case CategoriaGasto.transporte:
        return const Color(0xFF118AB2);
      case CategoriaGasto.outro:
        return const Color(0xFF9B5DE5);
    }
  }
}

class GastoRecorrente {
  final String nome;
  final double valor;
  final String descricao;
  final CategoriaGasto categoria;
  final FrequenciaGasto frequencia;

  GastoRecorrente({
    required this.nome,
    required this.valor,
    this.descricao = '',
    this.categoria = CategoriaGasto.outro,
    this.frequencia = FrequenciaGasto.mensal,
  });

  double get valorMensal {
    switch (frequencia) {
      case FrequenciaGasto.mensal:
        return valor;
      case FrequenciaGasto.anual:
        return valor / 12;
      case FrequenciaGasto.semanal:
        return valor * 4.33;
    }
  }

  double get valorAnual {
    switch (frequencia) {
      case FrequenciaGasto.mensal:
        return valor * 12;
      case FrequenciaGasto.anual:
        return valor;
      case FrequenciaGasto.semanal:
        return valor * 52;
    }
  }
}
