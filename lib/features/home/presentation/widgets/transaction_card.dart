import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color circleColor;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.circleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.background3, // El fondo oscuro de tus capturas
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Círculo con icono
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 25),
              ),
              const SizedBox(width: 20),
              // Texto central
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Flecha derecha decorativa
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textInactive, // Color tenue para la flecha
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
