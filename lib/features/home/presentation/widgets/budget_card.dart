import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:money2/money2.dart';

class BudgetCard extends StatelessWidget {
  final Money spent;
  final Money limit;

  const BudgetCard({super.key, required this.spent, required this.limit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    value:
                        spent.minorUnits.toDouble() /
                        limit.minorUnits.toDouble(),
                    strokeWidth: 10,
                    backgroundColor: Colors.white.withOpacity(0.05),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accent,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  '${(spent.minorUnits.toDouble() / limit.minorUnits.toDouble() * 100).toStringAsFixed(0)}%',
                  style: GoogleFonts.inter(
                    color: AppColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 25),
          // Información de texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Limite mensual',
                  style: TextStyle(color: AppColors.textInactive, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  limit.toString(),
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Restante ',
                      style: TextStyle(
                        color: AppColors.textInactive,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      (limit - spent).toString(),
                      style: TextStyle(
                        color: AppColors.textInactive2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
