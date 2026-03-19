// card_data.dart
import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double percentChange;
  final bool isPositive;

  const CardData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.percentChange,
    required this.isPositive,
  });
}

final List<CardData> financialCards = [
  const CardData(
    title: 'Receita Total',
    value: 'R\$ 84.250',
    subtitle: 'Este mês',
    icon: Icons.trending_up_rounded,
    color: Color(0xFF16213E),
    percentChange: 12.5,
    isPositive: true,
  ),
  const CardData(
    title: 'Despesas',
    value: 'R\$ 31.780',
    subtitle: 'Este mês',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF1A1A2E),
    percentChange: 4.2,
    isPositive: false,
  ),
  const CardData(
    title: 'Lucro Líquido',
    value: 'R\$ 52.470',
    subtitle: 'Este mês',
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF0F3460),
    percentChange: 18.9,
    isPositive: true,
  ),
  const CardData(
    title: 'Clientes Ativos',
    value: '1.284',
    subtitle: 'Total cadastrados',
    icon: Icons.people_alt_rounded,
    color: Color(0xFF162447),
    percentChange: 7.3,
    isPositive: true,
  ),
];