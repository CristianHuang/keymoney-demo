import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/features/budget/presentation/pages/goal_detail.dart';
import 'package:keymoneydemo/features/budget/presentation/widgets/goal_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class GoalIndexPage extends StatelessWidget {
  const GoalIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Metas de ahorro",
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
                        const GoalDetailPage(),
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
                    'Nueva meta',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: GoalCard(
                title: "Viaje a Japón",
                subtitle: "\$2.5k/\$5k",
                progress: 0.50,
                icon: Symbols.flight_takeoff,
                themeColor: const Color(0xFFA27DFF),
                isFullWidth: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GoalCard(
                title: "Nueva PC",
                subtitle: "\$1.2k/\$2k",
                progress: 0.60,
                icon: Symbols.computer,
                themeColor: const Color(0xFF7DDEFF),
                isFullWidth: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        GoalCard(
          title: "Fondo de emergencia",
          subtitle: "\$8,500 de \$10,000",
          progress: 0.84,
          icon: Symbols.savings,
          themeColor: const Color(0xFF7DFF83),
          deadline: "DEC 2026",
          isFullWidth: true,
        ),
      ],
    );
  }
}
