import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/features/budget/presentation/pages/budget_index_page.dart';
import 'package:keymoneydemo/features/budget/presentation/pages/goal_index_page.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const BudgetIndexPage(), const GoalIndexPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: Text(
          "PRESUPUESTO Y METAS",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background3,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(child: _tabItem(0, "Presupuesto")),
                      Expanded(child: _tabItem(1, "Metas")),
                    ],
                  ),
                ),
              ),
              IndexedStack(index: _selectedIndex, children: _pages),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabItem(int index, String label) {
    final bool isSelected = _selectedIndex == index;
    final Color colorText = isSelected
        ? AppColors.background3
        : AppColors.textInactive;
    final Color colorBackground = isSelected
        ? AppColors.white
        : AppColors.background3;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: colorBackground,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: colorText,
          ),
        ),
      ),
    );
  }
}
