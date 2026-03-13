import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:material_symbols_icons/symbols.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Symbols.construction,
              size: 130,
              color: AppColors.textInactive2,
            ),
            Text(
              'Estamos trabajando en esto',
              style: TextStyle(
                color: AppColors.textInactive,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
