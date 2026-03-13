import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:money2/money2.dart';

class AccountCard extends StatelessWidget {
  final String accountName;
  final String accountType;
  final Money balance;
  final SvgPicture bankIcon;

  const AccountCard({
    super.key,
    required this.accountName,
    required this.accountType,
    required this.balance,
    required this.bankIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 135,
      decoration: BoxDecoration(
        color: AppColors.background3,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bankIcon,
          SizedBox(height: 10),
          Text(
            accountType,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            accountName,
            style: TextStyle(
              color: AppColors.textInactive,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 10),
          Text(
            balance.toString(),
            style: TextStyle(
              color: AppColors.text,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
