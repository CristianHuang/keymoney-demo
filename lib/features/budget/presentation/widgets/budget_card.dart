import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:money2/money2.dart';
import 'package:keymoneydemo/core/util/money_extensions.dart';

class BudgetWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Money totalBudget;
  final Money spentAmount;
  final Money dailyUsage;
  final Color themeColor;

  const BudgetWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.totalBudget,
    required this.spentAmount,
    required this.dailyUsage,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        (double.parse(spentAmount.amount.toString()) /
                double.parse(totalBudget.amount.toString()))
            .clamp(0.0, 1.0);
    bool isCritical = percentage >= 0.95;
    Money remaining = totalBudget - spentAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background3,
        borderRadius: BorderRadius.circular(24),
        border: isCritical ? Border.all(color: themeColor, width: 2) : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.white, size: 35),
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
                      isCritical
                          ? "LÍMITE CRÍTICO ALCANZADO"
                          : "Quedan ${remaining.compactFormat()} este mes",
                      style: TextStyle(
                        color: isCritical ? themeColor : AppColors.textInactive,
                        fontWeight: isCritical
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    spentAmount.compactFormat(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "de ${totalBudget.compactFormat()}",
                    style: const TextStyle(
                      color: AppColors.textInactive,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 15,
                decoration: BoxDecoration(
                  color: AppColors.textInactive,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 15,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCritical
                    ? "QUEDAN ${remaining.toString()}"
                    : "Uso diario: ${dailyUsage.toString()}",
                style: TextStyle(
                  color: isCritical ? themeColor : AppColors.textInactive,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "${(percentage * 100).toInt()}% usado",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
