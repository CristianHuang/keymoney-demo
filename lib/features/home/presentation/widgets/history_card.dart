import 'dart:core';

import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money2/money2.dart';

class HistoryCard extends StatelessWidget {
  final SvgPicture bankIcon;
  final String title;
  final String category;
  final String time;
  final Money amount;
  final String type;

  const HistoryCard({
    super.key,
    required this.bankIcon,
    required this.title,
    required this.category,
    required this.time,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              bankIcon,
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: AppColors.textInactive,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " · hace $time",
                        style: TextStyle(
                          color: AppColors.textInactive,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${type == 'income' ? '+' : '-'}${amount.toString()}",
            style: TextStyle(
              color: type == 'income' ? AppColors.white : AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
