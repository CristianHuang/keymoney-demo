import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';

void customBottomSheet(
  BuildContext context,
  Function() functionPrimary,
  Function() functionSecondary,
  IconData icon,
  Color iconColor,
  String title,
  String subtitle,
  String primaryButton,
  String secondaryButton,
  Color primaryButtonColor,
  Color secondaryButtonColor,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.background2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 75,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.background3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              Icon(icon, color: iconColor, size: 65),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textInactive, fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: functionPrimary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryButtonColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 65),
                ),
                child: Text(
                  primaryButton,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: functionSecondary,
                child: Text(
                  secondaryButton,
                  style: TextStyle(
                    color: secondaryButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
