import 'package:flutter/material.dart';
import '../../models/gasto_recorrente.dart';

class DetalheGastoScreen extends StatelessWidget {
  final GastoRecorrente gasto;

  const DetalheGastoScreen({super.key, required this.gasto});

  void _confirmarDelecao(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Remover gasto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Deseja remover "${gasto.nome}" da lista?',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, true);
            },
            child: const Text(
              'Remover',
              style: TextStyle(
                  color: Color(0xFFEF476F), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                color: Color(0xFFEF476F)),
            onPressed: () => _confirmarDelecao(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: gasto.categoria.color.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: gasto.categoria.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      gasto.categoria.icon,
                      color: gasto.categoria.color,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    gasto.nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: gasto.categoria.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      gasto.categoria.label,
                      style: TextStyle(
                        color: gasto.categoria.color,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (gasto.descricao.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      gasto.descricao,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Valores
            Row(
              children: [
                Expanded(
                  child: _buildValorCard(
                    label: 'Valor ${gasto.frequencia.label}',
                    valor: 'R\$ ${gasto.valor.toStringAsFixed(2)}',
                    color: gasto.categoria.color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildValorCard(
                    label: 'Por mês',
                    valor: 'R\$ ${gasto.valorMensal.toStringAsFixed(2)}',
                    color: const Color(0xFF06D6A0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _buildValorCard(
              label: 'Custo anual estimado',
              valor: 'R\$ ${gasto.valorAnual.toStringAsFixed(2)}',
              color: const Color(0xFFFFD166),
              fullWidth: true,
            ),

            const SizedBox(height: 20),

            // Info frequência
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.repeat_rounded,
                    color: Colors.white.withOpacity(0.4),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Frequência: ${gasto.frequencia.label}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValorCard({
    required String label,
    required String valor,
    required Color color,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: fullWidth
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            valor,
            style: TextStyle(
              color: color,
              fontSize: fullWidth ? 20 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}