// todo_screen.dart
import 'package:flutter/material.dart';

// Modelo da tarefa
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Tarefa> _tarefas = [
    Tarefa(titulo: 'Pagar fatura do cartão'),
    Tarefa(titulo: 'Revisar orçamento do mês'),
    Tarefa(titulo: 'Transferir para reserva de emergência', concluida: true),
  ];

  // Filtro atual: 0 = Todas, 1 = Pendentes, 2 = Concluídas
  int _filtroAtual = 0;

  late AnimationController _fabController;
  late Animation<double> _fabAnim;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabAnim = CurvedAnimation(parent: _fabController, curve: Curves.easeOut);
    _fabController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fabController.dispose();
    super.dispose();
  }

  List<Tarefa> get _tarefasFiltradas {
    switch (_filtroAtual) {
      case 1:
        return _tarefas.where((t) => !t.concluida).toList();
      case 2:
        return _tarefas.where((t) => t.concluida).toList();
      default:
        return _tarefas;
    }
  }

  int get _totalConcluidas => _tarefas.where((t) => t.concluida).length;

  void _adicionarTarefa() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    setState(() {
      _tarefas.add(Tarefa(titulo: texto));
    });
    _controller.clear();
  }

  void _toggleTarefa(Tarefa tarefa) {
    setState(() {
      tarefa.concluida = !tarefa.concluida;
    });
  }

  void _removerTarefa(Tarefa tarefa) {
    setState(() {
      _tarefas.remove(tarefa);
    });
  }

  void _limparConcluidas() {
    setState(() {
      _tarefas.removeWhere((t) => t.concluida);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtradas = _tarefasFiltradas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header com contador
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tarefas Financeiras',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_totalConcluidas de ${_tarefas.length} concluídas',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              // Barra de progresso
              if (_tarefas.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _totalConcluidas / _tarefas.length,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF06D6A0),
                    ),
                    minHeight: 6,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Filtros
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFiltroChip('Todas', 0),
              const SizedBox(width: 8),
              _buildFiltroChip('Pendentes', 1),
              const SizedBox(width: 8),
              _buildFiltroChip('Concluídas', 2),
              const Spacer(),
              if (_totalConcluidas > 0)
                GestureDetector(
                  onTap: _limparConcluidas,
                  child: Text(
                    'Limpar concluídas',
                    style: TextStyle(
                      color: const Color(0xFFFF6B6B).withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Campo de adicionar tarefa — animação de entrada com ScaleTransition
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScaleTransition(
            scale: _fabAnim,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.add_task_rounded,
                    color: Color(0xFF4361EE),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nova tarefa financeira...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onSubmitted: (_) => _adicionarTarefa(),
                    ),
                  ),
                  GestureDetector(
                    onTap: _adicionarTarefa,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4361EE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Lista de tarefas
        Expanded(
          child: filtradas.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtradas.length,
                  itemBuilder: (context, index) {
                    return _buildTarefaItem(filtradas[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFiltroChip(String label, int index) {
    final bool ativo = _filtroAtual == index;
    return GestureDetector(
      onTap: () => setState(() => _filtroAtual = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: ativo
              ? const Color(0xFF4361EE).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ativo
                ? const Color(0xFF4361EE).withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: ativo ? const Color(0xFF4361EE) : Colors.white38,
            fontSize: 12,
            fontWeight: ativo ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildTarefaItem(Tarefa tarefa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: tarefa.concluida
              ? const Color(0xFF06D6A0).withOpacity(0.2)
              : Colors.white.withOpacity(0.06),
        ),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: GestureDetector(
          onTap: () => _toggleTarefa(tarefa),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: tarefa.concluida
                  ? const Color(0xFF06D6A0)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: tarefa.concluida
                    ? const Color(0xFF06D6A0)
                    : Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: tarefa.concluida
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
        ),
        title: Text(
          tarefa.titulo,
          style: TextStyle(
            color: tarefa.concluida
                ? Colors.white.withOpacity(0.35)
                : Colors.white.withOpacity(0.85),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: tarefa.concluida
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: Colors.white.withOpacity(0.35),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Colors.white.withOpacity(0.25),
            size: 20,
          ),
          onPressed: () => _removerTarefa(tarefa),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_rounded,
            color: Colors.white.withOpacity(0.1),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma tarefa aqui!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Adicione uma tarefa financeira acima.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.2),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}