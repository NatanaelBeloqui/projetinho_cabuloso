// responsive_card_grid.dart
import 'package:flutter/material.dart';
import '../models/card_data.dart';
import 'dashboard_card.dart';

enum LayoutType { mobile, tablet, desktop }

class ResponsiveCardGrid extends StatefulWidget {
  const ResponsiveCardGrid({super.key});

  @override
  State<ResponsiveCardGrid> createState() => _ResponsiveCardGridState();
}

class _ResponsiveCardGridState extends State<ResponsiveCardGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _layoutController;
  LayoutType? _previousLayout;

  @override
  void initState() {
    super.initState();
    _layoutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _layoutController.dispose();
    super.dispose();
  }

  LayoutType _getLayoutType(double width) {
    if (width < 600) return LayoutType.mobile;
    if (width < 900) return LayoutType.tablet;
    return LayoutType.desktop;
  }

  Future<void> _animateLayoutChange() async {
    await _layoutController.reverse();
    await _layoutController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery para detectar largura
    final double screenWidth = MediaQuery.of(context).size.width;
    final LayoutType currentLayout = _getLayoutType(screenWidth);

    // Animar quando o layout muda
    if (_previousLayout != null && _previousLayout != currentLayout) {
      _animateLayoutChange();
    }
    _previousLayout = currentLayout;

    return FadeTransition(
      opacity: _layoutController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // LayoutBuilder avançado para componentização
          if (currentLayout == LayoutType.mobile) {
            return _buildMobileLayout();
          } else if (currentLayout == LayoutType.tablet) {
            return _buildTabletLayout(constraints.maxWidth);
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  // 📱 Mobile: Column - 1 card por linha
  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: financialCards
            .map((card) => DashboardCard(data: card))
            .toList(),
      ),
    );
  }

  // 💻 Tablet: Wrap - 2 cards por linha (grid 2x2)
  Widget _buildTabletLayout(double maxWidth) {
    final cardWidth = (maxWidth / 2) - 24;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        children: financialCards
            .map((card) => DashboardCard(data: card, width: cardWidth))
            .toList(),
      ),
    );
  }

  // 🖥️ Desktop: Row - 4 cards na mesma linha
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: financialCards
            .map(
              (card) => Expanded(
                child: DashboardCard(data: card),
              ),
            )
            .toList(),
      ),
    );
  }
}