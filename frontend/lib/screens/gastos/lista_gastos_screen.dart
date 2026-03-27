// lista_gastos_screen.dart
import 'package:flutter/material.dart';
import '../../models/gasto_recorrente.dart';
import 'cadastro_gasto_screen.dart';
import 'detalhe_gasto_screen.dart';

class ListaGastosScreen extends StatefulWidget {
  const ListaGastosScreen({super.key});

  @override
  State<ListaGastosScreen> createState() => _ListaGastosScreenState();
}

class _ListaGastosScreenState extends State<ListaGastosScreen> {
  final List<GastoRecorrente> _gastos = [
    GastoRecorrente(
      nome: 'Netflix',
      valor: 39.90,
      descricao: 'Plano família',
      categoria: CategoriaGasto.assinatura,
      frequencia: FrequenciaGasto.mensal,
    ),
    GastoRecorrente(
      nome: 'Academia',
      valor: 89.90,
      descricao: 'Smart Fit — plano black',
      categoria: CategoriaGasto.saude,
      frequencia: FrequenciaGasto.mensal,
    ),
  ];

  double get _totalMensal =>
      _gastos.fold(0, (sum, g) => sum + g.valorMensal);

  Future<void> _abrirCadastro() async {
    final novoGasto = await Navigator.push<GastoRecorrente>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroGastoScreen()),
    );
    if (novoGasto != null) {
      setState(() => _gastos.add(novoGasto));
    }
  }

  void _abrirDetalhes(GastoRecorrente gasto, int index) async {
    final deletado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheGastoScreen(gasto: gasto),
      ),
    );
    if (deletado == true) {
      setState(() => _gastos.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        title: const Text(
          'Gastos Recorrentes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          if (_gastos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'R\$ ${_totalMensal.toStringAsFixed(2)}/mês',
                    style: const TextStyle(
                      color: Color(0xFF06D6A0),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _gastos.isEmpty ? _buildEmpty() : _buildLista(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        backgroundColor: const Color(0xFF4361EE),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.repeat_rounded,
            size: 64,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum gasto cadastrado',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no + para adicionar',
            style: TextStyle(
              color: Colors.white.withOpacity(0.25),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLista() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      itemCount: _gastos.length,
      itemBuilder: (context, index) {
        final gasto = _gastos[index];
        return _GastoTile(
          gasto: gasto,
          onTap: () => _abrirDetalhes(gasto, index),
        );
      },
    );
  }
}

class _GastoTile extends StatelessWidget {
  final GastoRecorrente gasto;
  final VoidCallback onTap;

  const _GastoTile({required this.gasto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: gasto.categoria.color.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: gasto.categoria.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                gasto.categoria.icon,
                color: gasto.categoria.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gasto.nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${gasto.categoria.label} · ${gasto.frequencia.label}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${gasto.valor.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: gasto.categoria.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gasto.frequencia == FrequenciaGasto.mensal
                      ? '/mês'
                      : 'R\$ ${gasto.valorMensal.toStringAsFixed(2)}/mês',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.2),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}