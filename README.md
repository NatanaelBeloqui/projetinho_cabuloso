# 📊 Finance Dashboard Responsivo

> **Atividade Prática — Aula 6 | SENAC Joinville**  
> Desenvolvimento para Dispositivos Móveis — 5ª Fase ADS 2026/1

---

## 👤 Informações do Aluno

| Campo | Dado |
|-------|------|
| **Nome** | [Seu Nome Aqui] |
| **Turma** | ADS 5ª Fase — 2026/1 |
| **Disciplina** | Desenvolvimento para Dispositivos Móveis |

---

## 📱 Screenshots dos 3 Breakpoints

### 📱 Mobile (< 600px) — Column Layout
> *(Adicione aqui seu screenshot mobile)*

### 💻 Tablet (600–900px) — Wrap 2×2 Layout
> *(Adicione aqui seu screenshot tablet)*

### 🖥️ Desktop (> 900px) — Row Layout
> *(Adicione aqui seu screenshot desktop)*

---

## ✅ Requisitos Implementados

### Obrigatórios
- [x] `MediaQuery.of(context).size.width` para detectar largura da tela
- [x] Lógica condicional `if/else` para escolher o layout
- [x] `Expanded` e `Flexible` para distribuir espaço nos cards
- [x] Widget reutilizável `DashboardCard`
- [x] `AppBar` com título do dashboard
- [x] `Scaffold` como estrutura principal
- [x] 4 cards com ícone, título, valor numérico e cor personalizada
- [x] Layout Mobile: `Column` (1 card por linha)
- [x] Layout Tablet: `Wrap` (2 cards por linha)
- [x] Layout Desktop: `Row` (4 cards lado a lado)

### Bônus ⭐
- [x] **Animações de transição** entre layouts (`FadeTransition` + `ScaleTransition`)
- [x] **Gráfico de barras** usando `Stack` e `Positioned` com animação
- [x] **`LayoutBuilder`** para componentização avançada
- [x] **`Drawer`** lateral com menu de navegação
- [x] **`BottomNavigationBar`** para mobile/tablet
- [x] **`NavigationRail`** para desktop

---

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                          # Entry point do app
├── models/
│   └── card_data.dart                 # Modelo de dados dos cards
├── screens/
│   └── dashboard_screen.dart          # Tela principal com Scaffold + Drawer
└── widgets/
    ├── dashboard_card.dart            # Widget reutilizável DashboardCard
    ├── responsive_card_grid.dart      # Grid responsivo com MediaQuery + LayoutBuilder
    └── mini_bar_chart.dart            # Gráfico de barras com Stack + Positioned
```

---

## 🚀 Como Executar

### Pré-requisitos
- [Flutter SDK](https://flutter.dev) instalado (versão 3.0+)
- Device ou emulador configurado

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/dashboard-responsivo-seunome.git
cd dashboard-responsivo-seunome

# 2. Instale as dependências
flutter pub get

# 3. Execute o app
flutter run

# Para testar responsividade no desktop:
flutter run -d windows  # ou macos/linux
```

### Testando os Breakpoints

| Como testar | Como fazer |
|---|---|
| **Desktop** | Redimensione a janela do app |
| **Tablet** | Use `Device Preview` ou emulador tablet |
| **Mobile** | Use emulador Android/iOS ou dispositivo físico |

---

## 🎨 Conceitos Utilizados

| Conceito | Onde foi usado |
|---|---|
| `MediaQuery` | `responsive_card_grid.dart` — detecta largura |
| `LayoutBuilder` | `responsive_card_grid.dart` — componentização |
| `Stack` + `Positioned` | `dashboard_card.dart` e `mini_bar_chart.dart` |
| `Expanded` | Layout Desktop (Row com 4 cards) |
| `Flexible` | Espaçamento dinâmico nos layouts |
| `Wrap` | Layout Tablet (grid 2×2) |
| `AnimationController` | Entrada dos cards + transição de layout |
| `Drawer` | Menu lateral de navegação |
| `BottomNavigationBar` | Navegação no mobile/tablet |
| `NavigationRail` | Navegação lateral no desktop |

---

*Desenvolvido para a disciplina de Desenvolvimento para Dispositivos Móveis — SENAC Joinville 2026/1*