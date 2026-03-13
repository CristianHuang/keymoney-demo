import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress; // Valor entre 0.0 y 1.0
  final String? deadline;
  final IconData icon;
  final Color themeColor;
  final bool isFullWidth;

  const GoalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.icon,
    required this.themeColor,
    this.deadline,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    // Calculamos el porcentaje para mostrar
    final String percentageText = "${(progress * 100).toInt()}%";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background3,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFullWidth)
            _buildFullWidthHeader(percentageText)
          else
            _buildCompactHeader(percentageText),
          const SizedBox(height: 16),
          // Barra de Progreso
          Stack(
            children: [
              Container(
                height: 15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.textInactive,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          if (isFullWidth && deadline != null) ...[
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "META: $deadline",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Diseño para versión 100% ancho
  Widget _buildFullWidthHeader(String percentage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 35),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textInactive,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            color: themeColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Diseño para versión 50% ancho
  Widget _buildCompactHeader(String percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white, size: 35),
            Text(
              percentage,
              style: TextStyle(
                color: themeColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }
}
