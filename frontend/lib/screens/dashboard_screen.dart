import 'package:flutter/material.dart';
import '../widgets/responsive_card_grid.dart';
import '../widgets/mini_bar_chart.dart';
import 'todo_screen.dart';
import 'gastos/lista_gastos_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildPlaceholder('Relatórios', Icons.bar_chart_rounded);
      case 2:
        return const TodoScreen();
      case 3:
        return const ListaGastosScreen();
      case 4:
        return _buildPlaceholder('Configurações', Icons.settings_rounded);
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const ResponsiveCardGrid(),
          _buildChartSection(),
          _buildRecentTransactions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, Natanael 👋',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Seu Painel Financeiro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visão Geral',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const MiniBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = [
      ('Supermercado', '-R\$ 245,00', Icons.shopping_cart_rounded, false),
      ('Salário', '+R\$ 4.500,00', Icons.account_balance_rounded, true),
      ('Streaming', '-R\$ 39,90', Icons.play_circle_rounded, false),
      ('Freelance', '+R\$ 800,00', Icons.laptop_rounded, true),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transações Recentes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...transactions.map((t) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(t.$3,
                        color: t.$4
                            ? const Color(0xFF06D6A0)
                            : Colors.white.withOpacity(0.4),
                        size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(t.$1,
                          style: const TextStyle(color: Colors.white)),
                    ),
                    Text(
                      t.$2,
                      style: TextStyle(
                        color: t.$4
                            ? const Color(0xFF06D6A0)
                            : const Color(0xFFEF476F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String label, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.white.withOpacity(0.15)),
          const SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      drawer: isDesktop ? null : _buildDrawer(),
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF0A0A1A),
              elevation: 0,
              title: const Text(
                'Finance',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined,
                      color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
      body: isDesktop
          ? Row(
              children: [
                _buildNavigationRail(),
                Expanded(child: _buildBody()),
              ],
            )
          : _buildBody(),
      bottomNavigationBar: isDesktop
          ? null
          : isTablet
              ? null
              : _buildBottomNav(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0F1923),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF16213E)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF4361EE),
                  child: Icon(Icons.person_rounded, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text('Natanael',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Finanças Pessoais',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ),
          _buildDrawerItem(0, Icons.dashboard_rounded, 'Dashboard'),
          _buildDrawerItem(1, Icons.bar_chart_rounded, 'Relatórios'),
          _buildDrawerItem(2, Icons.checklist_rounded, 'Tarefas'),
          _buildDrawerItem(3, Icons.repeat_rounded, 'Gastos'),
          _buildDrawerItem(4, Icons.settings_rounded, 'Configurações'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String label) {
    final selected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon,
          color: selected ? const Color(0xFF4361EE) : Colors.white.withOpacity(0.4)),
      title: Text(label,
          style: TextStyle(
              color: selected ? Colors.white : Colors.white.withOpacity(0.4),
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      selected: selected,
      selectedTileColor: const Color(0xFF4361EE).withOpacity(0.1),
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: const Color(0xFF0F1923),
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) =>
          setState(() => _selectedIndex = index),
      labelType: NavigationRailLabelType.all,
      selectedIconTheme: const IconThemeData(color: Color(0xFF4361EE)),
      selectedLabelTextStyle: const TextStyle(color: Color(0xFF4361EE)),
      unselectedIconTheme:
          IconThemeData(color: Colors.white.withOpacity(0.3)),
      unselectedLabelTextStyle:
          TextStyle(color: Colors.white.withOpacity(0.3)),
      destinations: const [
        NavigationRailDestination(
            icon: Icon(Icons.dashboard_rounded), label: Text('Dashboard')),
        NavigationRailDestination(
            icon: Icon(Icons.bar_chart_rounded), label: Text('Relatórios')),
        NavigationRailDestination(
            icon: Icon(Icons.checklist_rounded), label: Text('Tarefas')),
        NavigationRailDestination(
            icon: Icon(Icons.repeat_rounded), label: Text('Gastos')),
        NavigationRailDestination(
            icon: Icon(Icons.settings_rounded), label: Text('Config')),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      backgroundColor: const Color(0xFF0F1923),
      selectedItemColor: const Color(0xFF4361EE),
      unselectedItemColor: Colors.white.withOpacity(0.3),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: 'Relatórios'),
        BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded), label: 'Tarefas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.repeat_rounded), label: 'Gastos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded), label: 'Config'),
      ],
    );
  }
}