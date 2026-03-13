import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/features/budget/presentation/pages/budget_detail.dart';
import 'package:keymoneydemo/features/budget/presentation/widgets/budget_card.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:money2/money2.dart';
import 'package:keymoneydemo/core/config/currency_config.dart';

class BudgetIndexPage extends StatelessWidget {
  const BudgetIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Presupuesto mensual",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const BudgetDetailPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.fastOutSlowIn;

                          var tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(141, 30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 14,
                    color: AppColors.white,
                    weight: 1000,
                  ),
                  Text(
                    'Nuevo presupuesto',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            BudgetWidget(
              title: "Comida",
              icon: Symbols.fork_spoon,
              totalBudget: Money.fromNumWithCurrency(600, CurrencyConfig.usd),
              spentAmount: Money.fromNumWithCurrency(450, CurrencyConfig.usd),
              dailyUsage: Money.fromNumWithCurrency(14.50, CurrencyConfig.usd),
              themeColor: const Color(0xFF7DFF83),
            ),
            const SizedBox(height: 10),
            BudgetWidget(
              title: "Transporte",
              icon: Symbols.airport_shuttle,
              totalBudget: Money.fromNumWithCurrency(200, CurrencyConfig.usd),
              spentAmount: Money.fromNumWithCurrency(120, CurrencyConfig.usd),
              dailyUsage: Money.fromNumWithCurrency(4.00, CurrencyConfig.usd),
              themeColor: const Color(0xFF7DDEFF),
            ),
            const SizedBox(height: 10),
            BudgetWidget(
              title: "Compras",
              icon: Symbols.local_mall,
              totalBudget: Money.fromNumWithCurrency(400, CurrencyConfig.usd),
              spentAmount: Money.fromNumWithCurrency(380, CurrencyConfig.usd),
              dailyUsage: Money.fromNumWithCurrency(10.00, CurrencyConfig.usd),
              themeColor: const Color(0xFFFD56DC),
            ),
          ],
        ),
      ],
    );
  }
}
