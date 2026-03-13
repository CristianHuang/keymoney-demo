import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/core/config/currency_config.dart';
import 'package:money2/money2.dart';

class GoalDetailPage extends StatefulWidget {
  const GoalDetailPage({super.key});

  @override
  State<GoalDetailPage> createState() => _GoalDetailPageState();
}

class _GoalDetailPageState extends State<GoalDetailPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.background),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B0ACC),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(350, 65),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: Text(
          "AGREGAR META",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Symbols.delete, color: AppColors.red),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    Symbols.flight_takeoff,
                    color: AppColors.white,
                    size: 65,
                  ),
                  Icon(Symbols.border_color, color: AppColors.white, size: 14),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "Nombre del ahorro",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Symbols.border_color, color: AppColors.white, size: 14),
                ],
              ),
              SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cantidad a ahorrar",
                  style: TextStyle(
                    color: AppColors.textInactive,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    Money.fromNumWithCurrency(0, CurrencyConfig.usd).format(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Symbols.border_color, color: AppColors.white, size: 14),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Haz gastado \$0 de \$0 este mes",
                  style: TextStyle(color: AppColors.textInactive, fontSize: 12),
                ),
              ),
              const SizedBox(height: 15),
              Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.textInactive,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: 20,
                        width: constraints.maxWidth * 0,
                        decoration: BoxDecoration(
                          color: BudgetColors.electricBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "--% Gastado",
                  style: TextStyle(
                    color: BudgetColors.electricBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Color",
                  style: TextStyle(
                    color: AppColors.textInactive,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: BudgetColors.electricBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -15,
                        child: Icon(
                          Symbols.border_color,
                          color: BudgetColors.electricBlue,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fecha límite (Opcional)",
                  style: TextStyle(
                    color: AppColors.textInactive,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.background3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Symbols.calendar_month,
                          color: AppColors.white,
                          size: 25,
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fecha",
                              style: TextStyle(
                                color: AppColors.textInactive,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "Feb 12 2027",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Symbols.arrow_forward_ios,
                        color: AppColors.textInactive,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Retirar ahorro",
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
