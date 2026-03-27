# 📊 Finance Dashboard — Flutter

Dashboard de **finanças pessoais** desenvolvido durante as aulas de Flutter no **SENAC Joinville**. O projeto foi construído incrementalmente a cada aula, evoluindo de um layout responsivo simples até um app multi-tela com navegação, estado e programação assíncrona.

---

## 📱 Telas e Funcionalidades

### 0 · Dashboard
Visão geral das finanças com cards animados e gráfico semanal.
- Cards responsivos com badge de variação percentual (↑ ↓)
- `AnimationController` + `ScaleTransition` + `FadeTransition` nos cards
- Gráfico de barras animado (`MiniBarChart`) com gradiente e glow dots
- Transações recentes com ícone e cor por tipo (receita/despesa)
- Saudação personalizada: *"Olá, Natanael 👋"*

### 1 · Relatórios
Placeholder reservado para implementação futura.

### 2 · Tarefas Financeiras
Gerenciador de tarefas com filtros e progresso visual.
- Adicionar e remover tarefas com feedback visual
- Marcar como concluída com checkbox animado
- Filtros: Todas / Pendentes / Concluídas
- Barra de progresso linear
- Botão "Limpar concluídas"
- Animação de entrada no campo de input via `ScaleTransition`

### 3 · Gastos Recorrentes *(Atividade Aula 08)*
Controle de assinaturas e mensalidades com 3 telas e navegação.
- **Lista** — exibe gastos com total mensal no AppBar e FAB para adicionar
- **Cadastro** — formulário com seleção de categoria (chip com ícone/cor) e frequência
- **Detalhes** — cálculo automático mensal/anual, botão de deletar com `AlertDialog`
- Navegação via `Navigator.push` + `await` + `pop` retornando dados
- 6 categorias: Assinatura, Moradia, Saúde, Educação, Transporte, Outro
- 3 frequências: Mensal, Anual, Semanal

### 4 · Hábitos Financeiros *(Miniprojeto)*
Controle diário de hábitos com carregamento assíncrono e 2 telas.
- **Lista** — spinner de carregamento via `Future.delayed`, barra de progresso do dia, `Switch` inline por hábito
- **Detalhes** — toggle animado, texto riscado ao concluir, retorno do estado atualizado via `pop`
- 5 hábitos pré-definidos com ícone e cor únicos
- Mensagem de celebração ao concluir todos: *"Todos os hábitos concluídos! 🎉"*

### 5 · Configurações
Placeholder reservado para implementação futura.

---

## 📐 Layout Responsivo

O app adapta a navegação e o grid de cards ao tamanho da tela:

| Largura | Navegação | Grid de Cards |
|---|---|---|
| `< 600px` (mobile) | `BottomNavigationBar` + `Drawer` | 1 coluna |
| `600–899px` (tablet) | `BottomNavigationBar` | 2 colunas (Wrap) |
| `≥ 900px` (desktop) | `NavigationRail` | 4 colunas (Row) |

A transição entre layouts é animada via `FadeTransition` no `ResponsiveCardGrid`.

---

## 🗂 Estrutura de Pastas

```
lib/
├── models/
│   ├── card_data.dart               # Dados dos cards do dashboard
│   ├── gasto_recorrente.dart        # Modelo + enums de categoria/frequência
│   └── habito.dart                  # Modelo + lista de hábitos iniciais
├── screens/
│   ├── dashboard_screen.dart        # Shell principal com navegação responsiva
│   ├── todo_screen.dart             # Tela de tarefas financeiras
│   ├── gastos/
│   │   ├── lista_gastos_screen.dart
│   │   ├── cadastro_gasto_screen.dart
│   │   └── detalhe_gasto_screen.dart
│   └── habitos/
│       ├── home_habitos_screen.dart
│       └── detalhe_habito_screen.dart
├── widgets/
│   ├── dashboard_card.dart          # Card animado com badge de variação
│   ├── mini_bar_chart.dart          # Gráfico de barras com AnimatedBuilder
│   └── responsive_card_grid.dart    # Grid responsivo (mobile/tablet/desktop)
└── main.dart
```

---

## 🧠 Conceitos Aplicados

| Conceito | Onde é usado |
|---|---|
| `StatefulWidget` + `setState` | Todas as telas interativas |
| `AnimationController` + `CurvedAnimation` | Cards, gráfico, campo de input |
| `ScaleTransition` / `FadeTransition` | Cards do dashboard, input de tarefas |
| `AnimatedBuilder` | Barras do `MiniBarChart` |
| `AnimatedContainer` | Chips de categoria, tiles de hábito |
| `Navigator.push` / `pop` com retorno de dados | Gastos Recorrentes e Hábitos |
| `Future.delayed` + `async/await` | Carregamento simulado em Hábitos |
| `LayoutBuilder` + `MediaQuery` | Grid responsivo de cards |
| `NavigationRail` / `BottomNavigationBar` / `Drawer` | Navegação por breakpoint |
| Separação em `models/`, `screens/`, `widgets/` | Todo o projeto |

---

## 🚀 Como Rodar

**Pré-requisito:** Flutter SDK `>=3.0.0`

```bash
# Instalar dependências
flutter pub get

# Rodar o app
flutter run
```

---

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
```

Sem pacotes externos — tudo com Flutter puro.

---

## 📝 Histórico de Atividades

| Aula | Conteúdo |
|---|---|
| Aula 06 | Layout responsivo, `BottomNavigationBar`, `NavigationRail`, cards animados, `MiniBarChart` |
| Aula 08 | Navegação multi-tela, passagem de dados via `push/pop`, formulário, `AlertDialog` |
| Miniprojeto | Dart assíncrono com `Future.delayed`, `StatefulWidget` em duas telas, hábitos financeiros |

---

<img width="1920" height="945" alt="chrome_VvrMzhTJha" src="https://github.com/user-attachments/assets/e0832596-1fa1-4f17-b4e1-73416f15a0c6" />

<img width="1920" height="945" alt="chrome_GGYAnmbSff" src="https://github.com/user-attachments/assets/4b67fed7-fe43-402e-b2ce-b36e05c4934a" />


*Projeto acadêmico — SENAC Joinville*
