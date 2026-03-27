// home_habitos_screen.dart
import 'package:flutter/material.dart';
import '../../models/habito.dart';
import 'detalhe_habito_screen.dart';

class HomeHabitosScreen extends StatefulWidget {
  const HomeHabitosScreen({super.key});

  @override
  State<HomeHabitosScreen> createState() => _HomeHabitosScreenState();
}

class _HomeHabitosScreenState extends State<HomeHabitosScreen> {
  List<Habito> _habitos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarHabitos();
  }

  Future<void> _carregarHabitos() async {
    // Simulando carregamento assíncrono com Future.delayed
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _habitos = List.from(habitosIniciais);
      _carregando = false;
    });
  }

  int get _concluidos => _habitos.where((h) => h.concluido).length;
  double get _progresso =>
      _habitos.isEmpty ? 0 : _concluidos / _habitos.length;

  Future<void> _abrirDetalhes(int index) async {
    final atualizado = await Navigator.push<Habito>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheHabitoScreen(habito: _habitos[index]),
      ),
    );
    if (atualizado != null) {
      setState(() => _habitos[index] = atualizado);
    }
  }

  void _toggleHabito(int index, bool valor) {
    setState(() => _habitos[index].concluido = valor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        title: const Text(
          'Hábitos Financeiros',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _carregando ? _buildLoading() : _buildConteudo(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: const Color(0xFF4361EE),
              strokeWidth: 3,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Carregando hábitos...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConteudo() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      children: [
        _buildProgressCard(),
        const SizedBox(height: 20),
        ..._habitos.asMap().entries.map(
              (entry) => _HabitoTile(
                habito: entry.value,
                onTap: () => _abrirDetalhes(entry.key),
                onToggle: (val) => _toggleHabito(entry.key, val),
              ),
            ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4361EE).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progresso de hoje',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                '$_concluidos/${_habitos.length}',
                style: const TextStyle(
                  color: Color(0xFF4361EE),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _progresso,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation<Color>(
                _progresso == 1.0
                    ? const Color(0xFF06D6A0)
                    : const Color(0xFF4361EE),
              ),
            ),
          ),
          if (_progresso == 1.0) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: Color(0xFF06D6A0), size: 16),
                const SizedBox(width: 6),
                Text(
                  'Todos os hábitos concluídos! 🎉',
                  style: TextStyle(
                    color: const Color(0xFF06D6A0).withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HabitoTile extends StatelessWidget {
  final Habito habito;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  const _HabitoTile({
    required this.habito,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: habito.concluido
              ? habito.cor.withOpacity(0.08)
              : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: habito.concluido
                ? habito.cor.withOpacity(0.4)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: habito.cor.withOpacity(habito.concluido ? 0.25 : 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                habito.icone,
                color: habito.cor.withOpacity(habito.concluido ? 1.0 : 0.7),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                habito.nome,
                style: TextStyle(
                  color: habito.concluido
                      ? Colors.white.withOpacity(0.4)
                      : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: habito.concluido
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: habito.concluido,
              onChanged: onToggle,
              activeColor: habito.cor,
              inactiveThumbColor: Colors.white.withOpacity(0.3),
              inactiveTrackColor: Colors.white.withOpacity(0.08),
            ),
          ],
        ),
      ),
    );
  }
}