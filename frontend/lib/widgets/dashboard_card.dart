// dashboard_card.dart
import 'package:flutter/material.dart';
import '../models/card_data.dart';

class DashboardCard extends StatefulWidget {
  final CardData data;
  final double? width;

  const DashboardCard({
    super.key,
    required this.data,
    this.width,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder para adaptar o card ao espaço real disponível
    return LayoutBuilder(
      builder: (context, constraints) {
        // isSmall = true em telas pequenas como iPhone SE (375px)
        final bool isSmall = constraints.maxWidth < 380;

        final double cardPadding  = isSmall ? 14 : 20;
        final double iconSize     = isSmall ? 20 : 24;
        final double iconPadding  = isSmall ? 8  : 10;
        final double valueSize    = isSmall ? 20 : 26;
        final double titleSize    = isSmall ? 12 : 14;
        final double subtitleSize = isSmall ? 11 : 12;
        final double spacingTop   = isSmall ? 12 : 20;

        return FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: widget.width,
              margin: const EdgeInsets.all(8),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // Card base
                  Container(
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: widget.data.color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.data.color.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: icone + badge de variacao
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(iconPadding),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.data.icon,
                                color: Colors.white,
                                size: iconSize,
                              ),
                            ),
                            _buildBadge(isSmall),
                          ],
                        ),
                        SizedBox(height: spacingTop),
                        // Valor numerico
                        Text(
                          widget.data.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: valueSize,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Titulo do card
                        Text(
                          widget.data.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: titleSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Subtitulo
                        Text(
                          widget.data.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: subtitleSize,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Circulos decorativos — Stack + Positioned (bonus)
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.04),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: -30,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.03),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : 8,
        vertical: isSmall ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: widget.data.isPositive
            ? Colors.greenAccent.withOpacity(0.2)
            : Colors.redAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.data.isPositive
              ? Colors.greenAccent.withOpacity(0.4)
              : Colors.redAccent.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.data.isPositive
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            color: widget.data.isPositive ? Colors.greenAccent : Colors.redAccent,
            size: isSmall ? 10 : 12,
          ),
          const SizedBox(width: 2),
          Text(
            '${widget.data.percentChange}%',
            style: TextStyle(
              color: widget.data.isPositive ? Colors.greenAccent : Colors.redAccent,
              fontSize: isSmall ? 10 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}