// detalhe_habito_screen.dart
import 'package:flutter/material.dart';
import '../../models/habito.dart';

class DetalheHabitoScreen extends StatefulWidget {
  final Habito habito;

  const DetalheHabitoScreen({super.key, required this.habito});

  @override
  State<DetalheHabitoScreen> createState() => _DetalheHabitoScreenState();
}

class _DetalheHabitoScreenState extends State<DetalheHabitoScreen> {
  late bool _concluido;

  @override
  void initState() {
    super.initState();
    _concluido = widget.habito.concluido;
  }

  void _toggle(bool valor) {
    setState(() => _concluido = valor);
  }

  void _voltar() {
    // Retorna o hábito atualizado para a tela anterior
    final habitoAtualizado = Habito(
      nome: widget.habito.nome,
      descricao: widget.habito.descricao,
      icone: widget.habito.icone,
      cor: widget.habito.cor,
      concluido: _concluido,
    );
    Navigator.pop(context, habitoAtualizado);
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
          onPressed: _voltar,
        ),
        title: const Text(
          'Detalhes do Hábito',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop && result == null) _voltar();
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.habito.cor.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: widget.habito.cor
                            .withOpacity(_concluido ? 0.3 : 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        widget.habito.icone,
                        color: widget.habito.cor,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.habito.nome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _concluido
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: _concluido
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Descrição
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Por que fazer isso?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.habito.descricao,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Toggle
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: _concluido
                      ? widget.habito.cor.withOpacity(0.12)
                      : const Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _concluido
                        ? widget.habito.cor.withOpacity(0.4)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _concluido
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: _concluido
                              ? widget.habito.cor
                              : Colors.white.withOpacity(0.3),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _concluido ? 'Concluído hoje!' : 'Marcar como feito',
                          style: TextStyle(
                            color: _concluido
                                ? widget.habito.cor
                                : Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _concluido,
                      onChanged: _toggle,
                      activeColor: widget.habito.cor,
                      inactiveThumbColor: Colors.white.withOpacity(0.3),
                      inactiveTrackColor: Colors.white.withOpacity(0.08),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Botão voltar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _voltar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.habito.cor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Salvar e voltar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}