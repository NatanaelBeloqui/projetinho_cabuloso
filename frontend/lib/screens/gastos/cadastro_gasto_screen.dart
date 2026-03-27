// cadastro_gasto_screen.dart
import 'package:flutter/material.dart';
import '../../models/gasto_recorrente.dart';

class CadastroGastoScreen extends StatefulWidget {
  const CadastroGastoScreen({super.key});

  @override
  State<CadastroGastoScreen> createState() => _CadastroGastoScreenState();
}

class _CadastroGastoScreenState extends State<CadastroGastoScreen> {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _descricaoController = TextEditingController();

  CategoriaGasto _categoriaSelecionada = CategoriaGasto.assinatura;
  FrequenciaGasto _frequenciaSelecionada = FrequenciaGasto.mensal;

  @override
  void dispose() {
    _nomeController.dispose();
    _valorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    final nome = _nomeController.text.trim();
    final valorText = _valorController.text.trim().replaceAll(',', '.');

    if (nome.isEmpty || valorText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha nome e valor'),
          backgroundColor: const Color(0xFFEF476F),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final valor = double.tryParse(valorText);
    if (valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Informe um valor válido'),
          backgroundColor: const Color(0xFFEF476F),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final gasto = GastoRecorrente(
      nome: nome,
      valor: valor,
      descricao: _descricaoController.text.trim(),
      categoria: _categoriaSelecionada,
      frequencia: _frequenciaSelecionada,
    );

    Navigator.pop(context, gasto);
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
          'Novo Gasto',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInput(
              controller: _nomeController,
              label: 'Nome do gasto',
              hint: 'Ex: Netflix, Aluguel...',
              icon: Icons.label_rounded,
            ),
            const SizedBox(height: 16),
            _buildInput(
              controller: _valorController,
              label: 'Valor (R\$)',
              hint: '0,00',
              icon: Icons.attach_money_rounded,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            _buildInput(
              controller: _descricaoController,
              label: 'Descrição (opcional)',
              hint: 'Ex: Plano família, conta principal...',
              icon: Icons.notes_rounded,
            ),
            const SizedBox(height: 24),
            _buildLabel('Categoria'),
            const SizedBox(height: 12),
            _buildCategorias(),
            const SizedBox(height: 24),
            _buildLabel('Frequência'),
            const SizedBox(height: 12),
            _buildFrequencias(),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4361EE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Salvar',
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
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
            prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.4), size: 20),
            filled: true,
            fillColor: const Color(0xFF16213E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4361EE),
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorias() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: CategoriaGasto.values.map((cat) {
        final selecionado = cat == _categoriaSelecionada;
        return GestureDetector(
          onTap: () => setState(() => _categoriaSelecionada = cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selecionado
                  ? cat.color.withOpacity(0.2)
                  : const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selecionado ? cat.color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(cat.icon,
                    size: 16,
                    color: selecionado
                        ? cat.color
                        : Colors.white.withOpacity(0.4)),
                const SizedBox(width: 6),
                Text(
                  cat.label,
                  style: TextStyle(
                    color: selecionado
                        ? cat.color
                        : Colors.white.withOpacity(0.4),
                    fontSize: 13,
                    fontWeight: selecionado
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFrequencias() {
    return Row(
      children: FrequenciaGasto.values.map((freq) {
        final selecionado = freq == _frequenciaSelecionada;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _frequenciaSelecionada = freq),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                  right: freq != FrequenciaGasto.semanal ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selecionado
                    ? const Color(0xFF4361EE).withOpacity(0.2)
                    : const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selecionado
                      ? const Color(0xFF4361EE)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Text(
                freq.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selecionado
                      ? const Color(0xFF4361EE)
                      : Colors.white.withOpacity(0.4),
                  fontSize: 13,
                  fontWeight:
                      selecionado ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}