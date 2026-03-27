// habito.dart
import 'package:flutter/material.dart';

class Habito {
  final String nome;
  final String descricao;
  final IconData icone;
  final Color cor;
  bool concluido;

  Habito({
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.cor,
    this.concluido = false,
  });
}

final List<Habito> habitosIniciais = [
  Habito(
    nome: 'Registrar gastos do dia',
    descricao:
        'Anote todos os gastos realizados hoje, por menores que sejam. Pequenos gastos acumulam e impactam o orçamento.',
    icone: Icons.edit_note_rounded,
    cor: const Color(0xFF4361EE),
  ),
  Habito(
    nome: 'Revisar orçamento',
    descricao:
        'Confira se os gastos do mês estão dentro do planejado. Ajuste categorias se necessário.',
    icone: Icons.account_balance_wallet_rounded,
    cor: const Color(0xFF06D6A0),
  ),
  Habito(
    nome: 'Verificar metas',
    descricao:
        'Acompanhe o progresso das suas metas financeiras. Celebre avanços e replneje o que estiver atrasado.',
    icone: Icons.flag_rounded,
    cor: const Color(0xFFFFD166),
  ),
  Habito(
    nome: 'Evitar compras por impulso',
    descricao:
        'Antes de comprar algo não planejado, espere 24 horas. Se ainda quiser depois, avalie se cabe no orçamento.',
    icone: Icons.block_rounded,
    cor: const Color(0xFFEF476F),
  ),
  Habito(
    nome: 'Guardar 10% do salário',
    descricao:
        'Separe pelo menos 10% da sua renda assim que receber. Pague a si mesmo primeiro antes de qualquer gasto.',
    icone: Icons.savings_rounded,
    cor: const Color(0xFF9B5DE5),
  ),
];